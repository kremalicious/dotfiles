########################################################################
# bash_profile, basically from the whole internet
# and a lot from @necolas, @mathiasbynens & @rtomayko
# 
# https://github.com/mathiasbynens/dotfiles
# https://github.com/necolas/dotfiles
# https://github.com/rtomayko/dotfiles
########################################################################


# ----------------------------------------------------------------------
# Load ~/.private, ~/.bash_prompt
# ----------------------------------------------------------------------

for file in ~/.{private,bash_prompt}; do
	[ -r "$file" ] && source "$file"
done
unset file

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# fuck that you have new mail shit
unset MAILCHECK

# ----------------------------------------------------------------------
#  PATH
# ----------------------------------------------------------------------

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin";

# if these bins exist, then add them to the PATH
ANDROID_HOME="/usr/local/Cellar/android-sdk/r18"
[ -d "$ANDROID_HOME" ] && PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools";

# add to beginning of PATH so that it always take precedence over /usr/bin
[ -d "/usr/local/bin" ] && PATH="/usr/local/bin:$PATH";
[ -d "/usr/local/mysql/bin" ] && PATH="/usr/local/mysql/bin:$PATH";

export PATH

# ----------------------------------------------------------------------
#  ALIASES
# ----------------------------------------------------------------------

alias ll='ls -la'
# Get into main server FAST. Server & port are in .ssh/config
alias krlc='ssh kremalicious'
# Terminal needs more Espresso
alias esp="open -a Espresso"
# Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
alias update='sudo softwareupdate -i -a; sudo gem update --system; sudo gem update; brew update; brew upgrade; npm update -g'

# ----------------------------------------------------------------------
# LSCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
