#!/usr/bin/env bash

########################################################################
# bash_profile, basically from the whole internet
# and a lot from @necolas, @mathiasbynens & @rtomayko
#
# https://github.com/mathiasbynens/dotfiles
# https://github.com/necolas/dotfiles
# https://github.com/rtomayko/dotfiles
########################################################################

# shellcheck source=/dev/null

# ----------------------------------------------------------------------
# Load ~/.private, ~/.bash_prompt
# ----------------------------------------------------------------------

for FILE in ~/.{bash_exports,bash_paths,bash_prompt,bash_aliases,private,inputrc}; do
    [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE"
done;
unset FILE;

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# fuck that you have new mail shit
unset MAILCHECK

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=4

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done

# Add tab completion for many Bash commands
if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi

if type brew 2&>/dev/null; then
  for completion_file in "$(brew --prefix)"/etc/bash_completion.d/*; do
    source "$completion_file"
  done
fi

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall;

# aws-cli tab completion
complete -C aws_completer aws


# ----------------------------------------------------------------------
#  rvm
# ----------------------------------------------------------------------

# Load RVM into a shell session *as a function*
# shellcheck source=/dev/null
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# ----------------------------------------------------------------------
#  nvm
# ----------------------------------------------------------------------

if [ -s "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# ----------------------------------------------------------------------
#  ssh hack for SSH_AUTH_SOCK
# ----------------------------------------------------------------------

if [ -S "$SSH_AUTH_SOCK" ]; then
    unset SSH_AUTH_SOCK
fi
