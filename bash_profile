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

for file in ~/.{bash_prompt,aliases,private,inputrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done;
unset file;

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

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# ----------------------------------------------------------------------
#  PATH
# ----------------------------------------------------------------------

# we want the various sbins on the path along with /usr/local/bin
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"
[ -d "$HOME/.bin" ] && PATH="$HOME/.bin:$PATH"

# if these bins exist, then add them to the PATH
ANDROID_HOME="/usr/local/opt/android-sdk"
[ -d "$ANDROID_HOME" ] && PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

[ -d "/usr/local/mysql/bin" ] && PATH="/usr/local/mysql/bin:$PATH"
[ -d "/usr/local/share/npm/bin" ] && PATH="/usr/local/share/npm/bin:$PATH"

[ -d "$HOME/.rvm/bin" ] && PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH;

# ----------------------------------------------------------------------
# LSCOLORS
# ----------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
