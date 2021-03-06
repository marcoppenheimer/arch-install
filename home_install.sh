#elinks
sudo pacman -Syu elinks

#link dots
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
cp -rs $(pwd)/dotfiles/.config/nnn ${HOME}/.config/
cp -rs $(pwd)/dotfiles/.config/tmux ${HOME}/.config/

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
yay -S --noconfirm zsh-vi-mode-git

#chrome
yay -S --noconfirm google-chrome

#wget
sudo pacman -S --noconfirm wget

#htop
sudo pacman -S --noconfirm htop

#bat
sudo pacman -S --noconfirm bat

#keyring
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
sudo pacman -S pipewire-pulse
sudo systemctl enable --now pipewire-pulse.service
sudo systemctl enable --now bluetooth.service

#screenshot
sudo pacman -S --noconfirm maim
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
yay -S catppuccin-gtk-theme
sudo pacman -S --noconfirm papirus-icon-theme

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

#v4l2
sudo pacman -S --noconfirm v4l2loopback-dkms

#nnn
cd /tmp
git clone https://github.com/jarun/nnn.git
cd nnn
make O_RESTOREPREVIEW=1 O_GITSTATUS=1 O_NERD=1
sudo mv nnn /usr/bin/nnn
sudo pacman -S --noconfirm tmux

#images
sudo pacman -S --noconfirm imagemagick
sudo pacman -S --noconfirm feh

#modprobes
sudo cp $HOME/arch-install/modprobes/* /etc/modules-load.d/

#ripgrep+fzf
sudo pacman -S --noconfirm ripgrep
sudo pacman -S --noconfirm fzf

#ytdl
sudo pacman -S --noconfirm youtube-dl
