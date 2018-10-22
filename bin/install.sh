#!/usr/bin/env bash
#
# creates symlinks from the home directory to
# any desired dotfiles in ~/dotfiles
#
# adapted from @michaeljsmalley
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

set e

# list of files/folders to symlink in homedir
FILES="bash_aliases bashrc bash_profile bash_paths bash_prompt bash_exports gemrc gitconfig gitignore hushlogin inputrc private npmrc bin tmux.conf vimrc"

# ----------------------------------------------------------------------
# create the private file first, will be symlinked but ignored by git
# ----------------------------------------------------------------------

touch private

# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the dotfiles directory
# specified in $FILES
# ----------------------------------------------------------------------

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

# ----------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------

echo "$(tput setaf 136)           Brewing all the things. "
echo "=============================================$(tput sgr0)"
"" # reset

./bin/install-brew.sh

echo "$(tput setaf 64)---------------------------------------------"
echo "                 ✓ done$(tput sgr0)"

# ----------------------------------------------------------------------
# Ruby
# ----------------------------------------------------------------------

echo "$(tput setaf 136)             Ruby all the things. "
echo "=============================================$(tput sgr0)"

./bin/install-ruby.sh

echo "$(tput setaf 64)---------------------------------------------"
echo "                 ✓ done$(tput sgr0)"

echo "$(tput setaf 64)============================================="
echo "                 ✓ all done"
echo "=============================================$(tput sgr0)"
