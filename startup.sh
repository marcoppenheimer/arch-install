sudo pacman -Syu elinks

#yay
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#chrome
yay -S --noconfirm google-chrome
if [[ $(xdpyinfo | grep dimensions) == *"2160"* ]]; then
    HIGH_RES=true
    echo "--force-device-scale-factor=2" >> $HOME/.config/chrome-flags.conf
fi

#neofetch
sudo pacman -S --noconfirm neofetch

#htop
sudo pacman -S --noconfirm htop

#bat
sudo pacman -S --noconfirm bat

#vscode
yay -S --noconfirm visual-studio-code-bin
sudo pacman -S --noconfirm gnome-keyring libsecret

#mpv
#also installs xdg
sudo pacman -S mpv

#spotify
yay -S --noconfirm spotify

#discord
sudo pacman -S discord

#qbittorrent
sudo pacman -S qbittorrent

#gcp sdk
yay -S --noconfirm google-cloud-sdk

#kitty
sudo pacman -S kitty

#steam
sudo pacman -S steam

#slack
yay -S --noconfirm slack-desktop

#rofi
sudo pacman -S rofi

#github
ssh-keygen
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

#bluetooth+audio
sudo pacman -S --noconfirm pavucontrol
sudo pacman -S --noconfirm bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
# bluetoothctl power on
# bluetoothctl trust <MAC>
# bluetoothctl pair <MAC>
# bluetoothctl connect <MAC>

#screenshot
yay -S --noconfirm ffcast
sudo pacman -S --noconfirm xclip 
sudo pacman -S --noconfirm slop

#fonts
sudo pacman -S noto-fonts-emoji
sudo pacman -S ttf-droid
sudo pacman -S ttf-ubuntu-font-family
sudo pacman -S ttf-dejavu
sudo pacman -S noto-fonts
sudo pacman -S ttf-roboto
#aliases
echo "alias c=clear" >> ~/.zshrc

#oh-my-zsh + powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
