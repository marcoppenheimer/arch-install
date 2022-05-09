export EDITOR="nvim"
export VISUAL="nvim"
export PATH="/home/marc/.pyenv/shims:${PATH}"
export LS_COLORS=$(vivid generate ~/.config/vivid/one-dark.yaml)
export PATH="$HOME/.poetry/bin:$PATH"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000 
export SAVEHIST=10000000 
export TERM=xterm-256color
export NNN_PLUG="p:preview-tui;"
export NNN_FIFO="/tmp/nnn.fifo"

BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

