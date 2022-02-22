#oh-my-zsh + overwrite base
export ZSH="~/.config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
sudo rm -r ~/.z*

# link dots
cp -rs $(pwd)/dotfiles/ ~/

#elinks
sudo pacman -Syu elinks

#vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#yay
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#default dirs
sudo pacman -S --noconfirm xdg-user-dirs

#chrome
yay -S --noconfirm google-chrome

#wget
sudo pacman -S --noconfirm wget

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
sudo pacman -S --noconfirm discord

#qbittorrent
sudo pacman -S --noconfirm qbittorrent

#kitty
sudo pacman -S --noconfirm kitty

#eyecandy
sudo pacman -S --noconfirm rofi
sudo pacman -S --noconfirm picom 
sudo pacman -S --noconfirm hsetroot
sudo pacman -S --noconfirm neofetch

#windows compatibility
sudo pacman -S --noconfirm ntfs-3g
sudo pacman -S --noconfirm unzip
sudo pacman -S --noconfirm chntpw

#disk formatting
sudo pacman -S --noconfirm parted
sudo pacman -S --noconfirm gptfdisk

#keyboard
sudo pacman -S --noconfirm qmk

#keys
ssh-keygen
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

#bluetooth+audio
sudo pacman -S --noconfirm pavucontrol
sudo pacman -S --noconfirm bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable --now bluetooth.service

#screenshot
yay -S --noconfirm ffcast
sudo pacman -S --noconfirm xclip 
sudo pacman -S --noconfirm slop

#fonts
yay -S --noconfirm nerd-fonts-dejavu-complete
sudo pacman -S noto-fonts-emoji
sudo pacman -S ttf-droid
sudo pacman -S ttf-ubuntu-font-family
sudo pacman -S ttf-dejavu
sudo pacman -S noto-fonts
sudo pacman -S ttf-roboto

#python
sudo pacman -S --noconfirm pyenv

#docker
sudo pacman -S --noconfirm docker

#gtk-theme
yay -S --noconfirm nordic-theme
sudo pacman -S --noconfirm papirus-icon	

#starship
sudo pacman -S starship
