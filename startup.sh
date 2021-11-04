sudo pacman -Syu elinks

#yay
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#oh-my-zsh + powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

#chrome
yay -S google-chrome
if [[ $(xdpyinfo | grep dimensions) == *"2160"* ]]; then
    HIGH_RES=true
    echo "--force-device-scale-factor=2" >> $HOME/.config/chrome-flags.conf
fi

#bat
sudo pacman -S --noconfirm bat

#vscode
yay -S --noconfirm visual-studio-code-bin

#mpv
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

#aliases
echo "alias c=clear" >> ~/.zshrc
