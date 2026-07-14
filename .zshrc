# ------------------------------
# Aliases and Keybindings
# ------------------------------
[ -f ~/.alias ] && source ~/.alias
[ -f ~/.config/zsh/zsh_keybinds ] && source ~/.config/zsh/zsh_keybinds

# ------------------------------
# Zinit (plugin manager)
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------
# Oh-My-Posh, zoxide, fzf
# ------------------------------
export PATH=$HOME/.local/bin:$PATH
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------
# Zsh Plugins
# ------------------------------
zinit light Aloxaf/fzf-tab
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# ------------------------------
# History
# ------------------------------
HISTFILE=~/.history
HISTSIZE=500
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups no_extended_history

# ------------------------------
# asdf (all plugins + shims)
# ------------------------------
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

export PATH="$HOME/.cargo/bin:$PATH"
# zoxide's own `zi` shortcut is dropped to avoid colliding with zinit's `zi` alias
eval "$(zoxide init zsh | sed '/^zi() {/,/^}/d')"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
