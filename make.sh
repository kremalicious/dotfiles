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

# dotfiles directory
dir=~/Projects/dotfiles
# list of files/folders to symlink in homedir
files="aliases bashrc bash_profile bash_prompt gitconfig gitignore_global hushlogin private tm_properties"

# ----------------------------------------------------------------------
# change to the dotfiles directory
# ----------------------------------------------------------------------
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the ~/dotfiles directory 
# specified in $files
# ----------------------------------------------------------------------
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "...all done"