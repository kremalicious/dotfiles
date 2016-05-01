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

for file in ~/.{bash_paths,bash_prompt,exports,aliases,inputrc,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done;
unset file;

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

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

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall;

# aws-cli tab completion
complete -C aws_completer aws


export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

# ----------------------------------------------------------------------
#  rvm
# ----------------------------------------------------------------------

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# ----------------------------------------------------------------------
#  gpg-agent
# ----------------------------------------------------------------------

if [ -f "$HOME/.gnupg/.gpg-agent-info" ] && [ -n "$(pgrep gpg-agent)" ]; then
    source "$HOME/.gnupg/.gpg-agent-info"
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file $HOME/.gnupg/.gpg-agent-info)
fi


# ----------------------------------------------------------------------
#  Google Cloud SDK
# ----------------------------------------------------------------------

if [ -s "$HOME/Code/google-cloud-sdk/" ]; then
    source "$HOME/Code/google-cloud-sdk/path.bash.inc"
    source "$HOME/Code/google-cloud-sdk/completion.bash.inc"
fi
