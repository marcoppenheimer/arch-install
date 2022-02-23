[[ -f "~/.config/zsh/env.zsh" ]] && source ~/.config/zsh/env.zsh
[[ -f "~/.config/zsh/aliases.zsh" ]] && source ~/.config/zsh/aliases.zsh
source ~/.config/oh-my-zsh/oh-my-zsh.sh

ZSH_THEME=""
plugins=(git)

eval "$(starship init zsh)"
