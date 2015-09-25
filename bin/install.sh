#!/bin/bash
#
# creates symlinks from the home directory to
# any desired dotfiles in ~/dotfiles
#
# adapted from @michaeljsmalley
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

# ----------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------

# default dir
$DOTFILES_DIR='~/Projects/dotfiles'

# dotfiles directory
dir=$DOTFILES_DIR

# list of files/folders to symlink in homedir
files="aliases bashrc bash_profile bash_paths bash_prompt exports gemrc gitconfig gitignore hushlogin inputrc private tm_properties npmrc bin"


# ----------------------------------------------------------------------
# change to the dotfiles directory
# ----------------------------------------------------------------------

cd $dir

# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the dotfiles directory
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


# ----------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------

echo "$(tput setaf 136)"
echo "           Brewing all the things. "
echo "============================================="
echo "$(tput sgr0)" # reset

./brew.sh

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset


# ----------------------------------------------------------------------
# npm
# ----------------------------------------------------------------------

echo "$(tput setaf 136)"
echo "             npm all the things. "
echo "============================================="
echo "$(tput sgr0)" # reset

./npm.sh

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset


# ----------------------------------------------------------------------
# Ruby
# ----------------------------------------------------------------------

echo "$(tput setaf 136)"
echo "             Ruby all the things. "
echo "============================================="
echo "$(tput sgr0)" # reset

./ruby.sh

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset


echo "$(tput setaf 64)" # green
echo "============================================="
echo "                 ✓ all done"
echo "============================================="
echo "$(tput sgr0)" # reset
