#!/usr/bin/env -S bash -e

# iwctl --passphrase PASSPHRASE station DEVICE connect SSID
# https://github.com/classy-giraffe/easy-arch/blob/main/easy-arch.sh
# https://github.com/picodotdev/alis/blob/master/alis.sh + https://github.com/picodotdev/alis/blob/master/alis.conf

#Cleaning
clear
read -r -p "Please insert the keymap you use: " keymap 
loadkeys $keymap

# Selecting display drivers. 
display_drivers_selector () {
    echo "List of display drivers:"
    echo "1) intel" 
    echo "2) nvidia" 
    echo "3) nouveau" 
    read -r -p "Insert the number of the corresponding display drivers: " choice
    case $choice in
        1 ) DISPLAY_DRIVER="intel"
            MKINITCPICO_KMS_MODULES="i915" 
            arch-chroot /mnt pacman -Syu --noconfirm --needed mesa
            arch-chroot /mnt pacman -Syu --noconfirm --needed lib32-mesa
            arch-chroot /mnt pacman -Syu --noconfirm --needed intel-media-driver
            echo "options i915 enable_fbc=1 fastboot=1" > /mnt/etc/modprobe.d/1915.conf
            ;;
        2 ) DISPLAY_DRIVER="nvidia"
            arch-chroot /mnt pacman -Syu --noconfirm --needed mesa
            arch-chroot /mnt pacman -Syu --noconfirm --needed nvidia-dkms
            arch-chroot /mnt pacman -Syu --noconfirm --needed lib32-nvidia-utils
            arch-chroot /mnt pacman -Syu --noconfirm --needed libva-mesa-driver
            arch-chroot /mnt pacman -Syu --noconfirm --needed lib32-libva-mesa-driver 
            MKINITCPICO_KMS_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm" 
            ;;
        3 ) DISPLAY_DRIVER="nouveau"
            arch-chroot /mnt pacman -Syu --noconfirm --needed mesa
            arch-chroot /mnt pacman -Syu --noconfirm --needed lib32-mesa
            arch-chroot /mnt pacman -Syu --noconfirm --needed libva-mesa-driver
            arch-chroot /mnt pacman -Syu --noconfirm --needed lib32-libva-mesa-driver 
            MKINITCPICO_KMS_MODULES="nouveau" 
            ;;
        * ) echo "You did not enter a valid selection."
            display_drivers_selector
    esac
}

# ------------------ STARTING ----------------------------------------------------------------
exec > >(tee -a build.log)
exec 2> >(tee -a build.log >&2)
set -o xtrace

#Configure time
timedatectl set-timezone Europe/London
timedatectl set-ntp true

# Selecting the target for the installation.
PS3="Select the disk where Arch Linux is going to be installed: "
select ENTRY in $(lsblk -dpnoNAME|grep -P "/dev/sd|nvme|vd");
do
    DISK=$ENTRY
    echo "Installing Arch Linux on $DISK."
    break
done

# Deleting old partition scheme.
read -r -p "This will delete the current partition table on $DISK. Do you agree [y/N]? " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]
then
    wipefs -af "$DISK" &>/dev/null
    sgdisk -Zo "$DISK" &>/dev/null
else
    echo "Quitting."
    exit
fi

# Creating a new partition scheme.
echo "Creating new partition scheme on $DISK."
parted -s "$DISK" \
    mklabel gpt \
    mkpart "ESP" fat32 1MiB 513MiB \
    mkpart "swap" linux-swap 513MiB 7513MiB \
    mkpart "root" ext4 7513MiB 100% \
    set 1 esp on

ESP="/dev/disk/by-partlabel/ESP"
swap="/dev/disk/by-partlabel/swap"
root="/dev/disk/by-partlabel/root"

# Informing the Kernel of the changes.
echo "Informing the Kernel about the disk changes."
partprobe "$DISK"

# Formatting the EFI as FAT32.
echo "Formatting the EFI Partition as FAT32."
mkfs.fat -n ESP -F32 $ESP

# Formatting the swap as FAT32.
echo "Formatting the swap Partition."
mkswap $swap

# Formatting the ESP as FAT32.
echo "Formatting the root Partition as ext4."
mkfs.ext4 $root

# Mounting.
mount $root /mnt
mkdir -p /mnt/boot/efi
mount $ESP /mnt/boot/efi
swapon $swap

UUID_BOOT=$(blkid -s PARTUUID -o value $ESP)
UUID_ROOT=$(blkid -s PARTUUID -o value $root)

# Installation.
echo "Server = https://mirrors.kernel.org/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
pacstrap /mnt base linux-zen linux linux-firmware linux-zen-headers base-devel
sed -i 's/#Color/Color/' /mnt/etc/pacman.conf
sed -i 's/#ParallelDownloads/ParallelDownloads/' /mnt/etc/pacman.conf
echo "" >> /mnt/etc/pacman.conf
echo "[multilib]" >> /mnt/etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /mnt/etc/pacman.conf
echo "" >> /mnt/etc/pacman.conf

# Setting Timezone and localisation.
read -r -p "Please insert the region and city you use (format: Region/City): " region_city
arch-chroot /mnt ln -s -f /usr/share/zoneinfo/$region_city /etc/localtime
arch-chroot /mnt hwclock --systohc 
read -r -p "Please insert the locale you use (format: xx_XX): " locale
echo "$locale.UTF-8 UTF-8"  > /etc/locale.gen
echo "$locale.UTF-8 UTF-8"  > /mnt/etc/locale.gen
echo "LANG=$locale.UTF-8" > /mnt/etc/locale.conf
locale-gen
arch-chroot /mnt locale-gen
echo "KEYMAP=$keymap" > /mnt/etc/vconsole.conf
arch-chroot /mnt mkdir -p "/etc/X11/xorg.conf.d/"
cat <<EOT > /mnt/etc/X11/xorg.conf.d/00-keyboard.conf
    # Written by systemd-localed(8), read by systemd-localed and Xorg. It's
    # probably wise not to edit this file manually. Use localectl(1) to
    # instruct systemd-localed to update it.
    Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        $OPTIONS
    EndSection
EOT

# Setting swappiness.
echo "vm.swappiness=10" > /mnt/etc/sysctl.d/99-sysctl.conf

# Setting hostname and password.
read -r -p "Please enter your desired hostname: " hostname
echo "$hostname" > /mnt/etc/hostname
read -r -p "Please enter your desired root password: " password 
printf "$password\n$password" | arch-chroot /mnt passwd

# Generating /etc/fstab.
echo "Generating a new fstab."
genfstab -U /mnt >> /mnt/etc/fstab

# Setting hosts file.
echo "Setting hosts file."
cat > /mnt/etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain   $hostname
EOF

# Installing display drivers.
echo "Installing display drivers."
display_drivers_selector

# Installing network.
echo "Installing network."
arch-chroot /mnt pacman -Syu --noconfirm --needed networkmanager
arch-chroot /mnt systemctl enable NetworkManager.service

# Creating personal user and groups.
echo "Creating personal user and groups."
read -r -p "Please enter your desired username: " username
read -r -p "Please enter your desired password: " user_password
arch-chroot /mnt useradd -m -G "wheel,storage,optical" -s /bin/bash $username
printf "$user_password\n$user_password" | arch-chroot /mnt passwd $username
arch-chroot /mnt sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Bootloader
CPU=$(grep vendor_id /proc/cpuinfo)
if [[ $CPU == *"AuthenticAMD"* ]]; then
    arch-chroot /mnt pacman -Syu --noconfirm --needed amd-ucode
    REFIND_MICROCODE="initrd=\amd-ucode.img"
else
    arch-chroot /mnt pacman -Syu --noconfirm --needed intel-ucode
    REFIND_MICROCODE="initrd=\intel-ucode.img"
fi

case "$DISPLAY_DRIVER" in "nvidia"|"nvidia-dkms"|"nvidia-390xx"|"nvidia-390xx-lts")
    CMDLINE_LINUX="nvidia-drm.modeset=1"
    ;;
esac

if [[ $DISK == *"nvme"* ]]; then
    KERNELS_PARAMETERS="nvme_load=YES"
fi

SILENT_PARAMS="quiet loglevel=3 vga=current rd.systemd.show_status=auto rd.udev.log_level=3 rd.udev.log_priority=3"
CMDLINE_LINUX="$CMDLINE_LINUX $KERNELS_PARAMETERS $SILENT_PARAMS"

# Configuring /etc/mkinitcpio.conf
echo "Configuring /etc/mkinitcpio.conf"
HOOKS="base udev usr keyboard autodetect modconf block keymap consolefont fsck filesystems"
arch-chroot /mnt sed -i "s/^HOOKS=(.*)/HOOKS=($HOOKS)/" /etc/mkinitcpio.conf
arch-chroot /mnt sed -i "s/^MODULES=(.*)/MODULES=($MKINITCPICO_KMS_MODULES)/" /etc/mkinitcpio.conf

# Configuring /etc/mkinitcpio.conf
echo "Configuring /etc/mkinitcpio.conf"
HOOKS="base udev usr keyboard autodetect modconf block keymap consolefont fsck filesystems"
arch-chroot /mnt sed -i "s/^HOOKS=(.*)/HOOKS=($HOOKS)/" /etc/mkinitcpio.conf
arch-chroot /mnt sed -i "s/^MODULES=(.*)/MODULES=($MKINITCPICO_KMS_MODULES)/" /etc/mkinitcpio.conf

# Setting mkinitcpio.
#echo "Setting mkinitcpio."
#arch-chroot /mnt mkinitcpio -P

# Setting mkinitcpio.
echo "Setting mkinitcpio."
cat <<EOT > "/mnt/etc/mkinitcpio.d/linux.preset"
# mkinitcpio preset file for the 'linux' package

cp -af "/boot/vmlinuz-linux\$suffix" "/boot/efi/"
cp -af "/boot/intel-ucode.img" "/boot/efi/"
cp -af "/boot/amd-ucode.img" "/boot/efi"
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/efi/vmlinuz-linux\$suffix"

PRESETS=('default' 'fallback')

#default_config="/etc/mkinitcpio.conf"
default_image="/boot/efi/initramfs-linux\$suffix.img"
#default_options=""

#fallback_config="/etc/mkinitcpio.conf"
fallback_image="/boot/efi/initramfs-linux-fallback.img"
fallback_options="-S autodetect"
EOT

cat <<EOT > "/mnt/etc/mkinitcpio.d/linux-zen.preset"
suffix='-zen'
source /etc/mkinitcpio.d/linux.preset
EOT

# Setting mkinitcpio.
echo "Setting mkinitcpio."
arch-chroot /mnt mkinitcpio -P

# Clearing up mkinitpcio files.
arch-chroot /mnt rm -f /boot/*

# Refind
arch-chroot /mnt pacman -Syu --noconfirm --needed gdisk
arch-chroot /mnt pacman -Syu --noconfirm --needed refind
arch-chroot /mnt refind-install

arch-chroot /mnt sed -i "s/^use_graphics_for.*/use_graphics_for linux/" /boot/efi/EFI/refind/refind.conf
arch-chroot /mnt sed -i "s/^#scan_all_linux_kernels.*/scan_all_linux_kernels false/" /boot/efi/EFI/refind/refind.conf
arch-chroot /mnt sed -i "s/^timeout.*/timeout 5/" /boot/efi/EFI/refind/refind.conf
cat <<EOT >> "/mnt/boot/efi/EFI/refind/refind.conf"
menuentry "Arch Linux (zen)" {
    volume    $UUID_BOOT    
    loader    \vmlinuz-linux-zen
    initrd    \initramfs-linux-zen.img
    icon      \EFI\refind\icons\os_arch.png
    options   "root=PARTUUID=$UUID_ROOT $REFIND_MICROCODE rw $CMDLINE_LINUX"
    submenuentry "Boot using fallback initramfs" {
        initrd \initramfs-linux-fallback.img
    }
    submenuentry "Boot to terminal" {
        add_options "systemd.unit=multi-user.target"
    }
}
EOT

arch-chroot /mnt rm /boot/refind_linux.conf

# Installing custom shell.
echo "Installing custom shell."
arch-chroot /mnt pacman -Syu --noconfirm --needed zsh
CUSTOM_SHELL_PATH="/usr/bin/zsh"
arch-chroot /mnt chsh -s "/usr/bin/zsh" "root" 
arch-chroot /mnt chsh -s "/usr/bin/zsh" $username 

# Installing WM/DE.
echo "Installing WM/DE."
arch-chroot /mnt pacman -Syu --noconfirm --needed i3-gaps i3blocks i3lock i3status dmenu rxvt-unicode lightdm lightdm-gtk-greeter xorg-server xorg-apps xorg-xinit
arch-chroot /mnt systemctl enable lightdm.service
arch-chroot /mnt systemctl set-default graphical.target

# Installing bare bones packages
arch-chroot /mnt pacman -Syu --noconfirm --needed neovim man-db man-pages texinfo elinks git base-devel
