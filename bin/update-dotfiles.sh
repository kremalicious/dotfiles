#!/usr/bin/env bash
#
# Pull in changes and make new symlinks
#
# adapted from @mathiasbynens & @michaeljsmalley
# https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

# list of files/folders to symlink in homedir
FILES="bash_aliases bashrc bash_profile bash_paths bash_prompt bash_exports editorconfig gitconfig gitignore hushlogin inputrc private bin tmux.conf vimrc"

for FILE in $FILES; do

    # remove old symlinks if present
    if [ -h "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "$(tput setaf 64)✓$(tput sgr0) Removed old symlink to $(tput setaf 37)$FILE$(tput sgr0)"
    fi

    # symlink files
    ln -s "$PWD/$FILE" "$HOME/.$FILE"
    echo "$(tput setaf 64)✓$(tput sgr0) Created new symlink to $(tput setaf 37)$FILE$(tput sgr0)"

done

# ----------------------------------------------------------------------
# source what we just created
# ----------------------------------------------------------------------

# shellcheck source=/dev/null
source "$HOME/.bash_profile"

exit
