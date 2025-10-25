# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
 
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias vi='nvim'
alias c='clear'
alias ll="eza -al --icons=always"
alias ls="eza --icons=always"
alias gco="git checkout"
alias gcd="git checkout dev"
alias gstl="git stash list"
alias gsts="git stash save"
alias gstaa="git stash apply"
alias gcb="git checkout -b"
alias gbd="git branch -D"
alias gstp="git stash pop"
alias gstd="git stash drop"

alias termconf="vi ~/.wezterm.lua"
alias tmuxconf="vi ~/.config/.tmux.conf"
alias zshconf="vi ~/.zshrc"


# tmux alias
alias tn='tmux new -s'
alias tls='tmux ls'
alias ta='tmux attach -t'
alias tat='tmux attach || tmux new'
alias ts='tmux switch -t'
alias tk='tmux kill-session -t'
alias tks='tmux kill-server'
alias td='tmux detach'

export STARSHIP_CONFIG=~/example/non/default/path/starship.toml
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
