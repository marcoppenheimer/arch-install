
ZSH_THEME=""
plugins=(git)



[[ -f "~/.config/zsh/env.zsh" ]] && source ~/.config/zsh/env.zsh
[[ -f "~/.config/zsh/aliases.zsh" ]] && source ~/.config/zsh/aliases.zsh
source $ZSH/oh-my-zsh.sh




eval "$(starship init zsh)"
