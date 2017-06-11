#!/usr/bin/env bash

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

for file in ~/.{exports,private,bash_paths,bash_prompt,aliases,inputrc}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done;
unset file;

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

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion;
fi;

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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# ----------------------------------------------------------------------
#  ssh hack for SSH_AUTH_SOCK
# ----------------------------------------------------------------------

if [ -S "$SSH_AUTH_SOCK" ]; then
    unset SSH_AUTH_SOCK
fi
