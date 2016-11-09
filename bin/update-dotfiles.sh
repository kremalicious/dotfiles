#!/usr/bin/env bash
#
# Pull in changes and make new symlinks
#
# adapted from @mathiasbynens & @michaeljsmalley
# https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

# ----------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------

# dotfiles directory
dir=$DOTFILES_DIR

# list of files/folders to symlink in homedir
files="aliases bashrc bash_profile bash_paths bash_prompt editorconfig exports gemrc gitconfig gitignore hushlogin inputrc private npmrc bin"


# ----------------------------------------------------------------------
# delete existing dotfiles in ~
# ----------------------------------------------------------------------

for file in $files; do
    rm ~/.$file
done


# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the ~/dotfiles directory
# specified in $files
# ----------------------------------------------------------------------

for file in $files; do
    ln -s $dir/$file ~/.$file
    echo "$(tput setaf 64)✓$(tput sgr0) Created symlink to $(tput setaf 37)$file$(tput sgr0)"
done


# ----------------------------------------------------------------------
# source what we just created
# ----------------------------------------------------------------------

source ~/.bash_profile
