# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure

# CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# Oh My Zsh
export ZSH="/Users/m/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# User configuration
source ~/.exports
source ~/.aliases
source ~/.private