#!/usr/bin/env -S bash -e

# iwctl --passphrase PASSPHRASE station DEVICE connect SSID
# https://github.com/classy-giraffe/easy-arch/blob/main/easy-arch.sh
# https://github.com/picodotdev/alis/blob/master/alis.sh + https://github.com/picodotdev/alis/blob/master/alis.conf
#Cleaning
clear

# Selecting a kernel to install. 
kernel_selector () {
    echo "List of kernels:"
    echo "1) Stable — Vanilla Linux kernel and modules, with a few patches applied."
    echo "2) Hardened — A security-focused Linux kernel."
    echo "3) Longterm — Long-term support (LTS) Linux kernel and modules."
    echo "4) Zen Kernel — Optimized for desktop usage."
    read -r -p "Insert the number of the corresponding kernel: " choice
    echo "$choice will be installed"
    case $choice in
        1 ) kernel=linux
            ;;
        2 ) kernel=linux-hardened
            ;;
        3 ) kernel=linux-lts
            ;;
        4 ) kernel=linux-zen
            ;;
        * ) echo "You did not enter a valid selection."
            kernel_selector
    esac
}

# Selecting a way to handle internet connection. 
network_selector () {
    echo "Network utilities:"
    echo "1) IWD — iNet wireless daemon is a wireless daemon for Linux written by Intel (WiFi-only)."
    echo "2) NetworkManager — Program for providing detection and configuration for systems to automatically connect to networks (both WiFi and Ethernet)."
    echo "3) wpa_supplicant — It's a cross-platform supplicant with support for WEP, WPA and WPA2 (WiFi-only, a DHCP client will be automatically installed too.)"
    echo "4) I will do this on my own."
    read -r -p "Insert the number of the corresponding networking utility: " choice
    echo "$choice will be installed"
    case $choice in
        1 ) echo "Installing IWD."    
            pacstrap /mnt iwd
            echo "Enabling IWD."
            systemctl enable iwd --root=/mnt &>/dev/null
            ;;
        2 ) echo "Installing NetworkManager."
            pacstrap /mnt networkmanager
            echo "Enabling NetworkManager."
            systemctl enable NetworkManager --root=/mnt &>/dev/null
            ;;
        3 ) echo "Installing wpa_supplicant and dhcpcd."
            pacstrap /mnt wpa_supplicant dhcpcd
            echo "Enabling wpa_supplicant and dhcpcd."
            systemctl enable wpa_supplicant --root=/mnt &>/dev/null
            systemctl enable dhcpcd --root=/mnt &>/dev/null
            ;;
        4 )
            ;;
        * ) echo "You did not enter a valid selection."
            network_selector
    esac

# Checking the microcode to install.
CPU=$(grep vendor_id /proc/cpuinfo)
if [[ $CPU == *"AuthenticAMD"* ]]
then
    microcode=amd-ucode
else
    microcode=intel-ucode
fi

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
