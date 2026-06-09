# zmodload zsh/zprof

#
# Prompt
# https://github.com/sindresorhus/pure
#
autoload -U promptinit; promptinit
# promptinit registers a prompt_<theme>_setup stub for every theme in fpath
if whence prompt_pure_setup > /dev/null; then
  PURE_GIT_DOWN_ARROW=↓
  PURE_GIT_UP_ARROW=↑
  prompt pure
  zstyle :prompt:pure:git:stash show yes
fi
export CLICOLOR=1

setopt correct

# Skip forward/back a word with opt-arrow
bindkey '^[f' forward-word
bindkey '^[b' backward-word

#
# History
#
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

#
# Changing directories
#
setopt auto_cd
setopt auto_pushd
unsetopt pushd_ignore_dups
setopt pushdminus

#
# Completion
#
# Full compinit only when the dump is older than 24h, otherwise skip the
# security check with -C for faster startup
autoload -Uz compinit
if [ -n "$(find ~/.zcompdump -mmin -1440 2> /dev/null)" ]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt auto_menu
setopt always_to_end
setopt complete_in_word
setopt prompt_subst
unsetopt flow_control
unsetopt menu_complete

# Source exports first (sets UNAME_SYSTEM)
source ~/.exports
source ~/.aliases
[ -f ~/.private ] && source ~/.private

# macOS: Homebrew plugins and tools
if [[ "$UNAME_SYSTEM" == "Darwin" ]]; then
  [ -f $PATH_HOMEBREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source $PATH_HOMEBREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  [ -f $PATH_HOMEBREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source $PATH_HOMEBREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# bun completions
[ -f "$BUNPATH/_bun" ] && source "$BUNPATH/_bun"

# Scaleway CLI autocomplete, lazy: real completion is generated on first use.
# The sed drops scw's own `compinit` call, compinit already ran above.
_scw() {
  unfunction _scw
  eval "$(scw autocomplete script shell=zsh | sed '/compinit/d')"
  _scw "$@"
}
compdef _scw scw

# OrbStack: command-line tools and integration
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh
