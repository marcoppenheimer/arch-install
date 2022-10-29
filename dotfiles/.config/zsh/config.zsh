source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
setopt inc_append_history
setopt extended_history
setopt share_history
setopt hist_save_no_dups
setopt hist_ignore_all_dups
unsetopt BEEP

bindkey "^R" history-incremental-search-backward
