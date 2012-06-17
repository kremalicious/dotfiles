########################################################################
# bash_profile, basically from the whole internet
# and a lot from @necolas, @mathiasbynens & @rtomayko
# 
# https://github.com/mathiasbynens/dotfiles
# https://github.com/necolas/dotfiles
# https://github.com/rtomayko/dotfiles
########################################################################


# ----------------------------------------------------------------------
# Load ~/.extra, ~/.bash_prompt
# ----------------------------------------------------------------------

for file in ~/.{extra,bash_prompt}; do
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

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:/usr/local/mysql/bin:$PATH"
# Android SDK
PATH="~/Dropbox/Code/android-sdk/tools:~/Dropbox/Code/android-sdk/platform-tools:$PATH"

# ----------------------------------------------------------------------
#  ALIASES
# ----------------------------------------------------------------------

alias ll='ls -la'
# Get into main server FAST. Server & port are in .ssh/config
alias krlc='ssh kremalicious'
# Terminal needs more Espresso
alias esp="open -a Espresso"
# Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade'

# ----------------------------------------------------------------------
# LSCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
