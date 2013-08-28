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

for file in ~/.{bash_prompt,aliases,private}; do
	[ -r "$file" ] && source "$file"
done
unset file

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# fuck that you have new mail shit
unset MAILCHECK

# ----------------------------------------------------------------------
#  PATH
# ----------------------------------------------------------------------

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin";

# if these bins exist, then add them to the PATH
ANDROID_HOME="/usr/local/Cellar/android-sdk/r22.0.4"
[ -d "$ANDROID_HOME" ] && PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools";

# add to beginning of PATH so that it always take precedence over /usr/bin
[ -d "/usr/local/bin" ] && PATH="/usr/local/bin:$PATH";
[ -d "/usr/local/mysql/bin" ] && PATH="/usr/local/mysql/bin:$PATH";
[ -d "/usr/local/share/npm/bin" ] && PATH="/usr/local/share/npm/bin:$PATH";

[ -d "$HOME/.rvm/bin" ] && PATH="$HOME/.rvm/bin:$PATH"; # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -d "/Applications/Vagrant/bin" ] && PATH="/Applications/Vagrant/bin:$PATH"; # vagrant binary

export PATH

# ----------------------------------------------------------------------
# LSCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
