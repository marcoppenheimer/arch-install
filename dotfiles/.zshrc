[[ -f "${HOME}/.config/zsh/aliases.zsh" ]] && source ~/.config/zsh/aliases.zsh
[[ -f "${HOME}/.config/zsh/env.zsh" ]] && source ~/.config/zsh/env.zsh
[[ -f "${HOME}/.config/zsh/config.zsh" ]] && source ~/.config/zsh/config.zsh
[[ -f "${HOME}/.config/zsh/functions.zsh" ]] && source ~/.config/zsh/functions.zsh

eval "$(starship init zsh)"
