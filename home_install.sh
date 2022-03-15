#elinks
sudo pacman -Syu elinks

# link dots
[ -d "${HOME}/.config" ] || mkdir ${HOME}/.config
cp -rs $(pwd)/dotfiles/.zshrc ${HOME}/.zshrc
cp -rs $(pwd)/dotfiles/.gitconfig ${HOME}/.gitconfig
cp -rs $(pwd)/dotfiles/.config/starship.toml ${HOME}/.config/starship.toml
cp -rs $(pwd)/dotfiles/.config/bat ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/flashfocus ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/fontconfig ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/gtk-3.0 ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/i3 ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/kitty ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/mpv ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/nvim ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/picom ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/rofi  ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/user-dirs.dirs ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/vivid ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/zsh ${HOME}/.config/

#yay
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#zsh-plugins
sudo pacman -S --noconfirm zsh-autosuggestions
sudo pacman -S --noconfirm zsh-completions
sudo pacman -S --noconfirm zsh-history-substring-search
sudo pacman -S --noconfirm zsh-syntax-highlighting

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
sudo pacman -S --noconfirm mpv

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
sudo pacman -S --noconfirm starship

#exa
sudo pacman -S --noconfirm exa

#vivid
sudo pacman -S --noconfirm vivid

#lsps
yay -S --noconfirm lua-language-server
yay -S --noconfirm pyright

#dust
yay -S --noconfirm dust-git

#rsync
sudo pacman -S --noconfirm rsync
