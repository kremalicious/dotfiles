#!/bin/bash
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
dir=~/Projects/dotfiles
# list of files/folders to symlink in homedir
files="aliases bashrc bash_profile bash_prompt gemrc gitconfig gitignore_global hushlogin inputrc private tm_properties generator.json npmrc"

# ----------------------------------------------------------------------
# change to the dotfiles directory
# ----------------------------------------------------------------------
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# ----------------------------------------------------------------------
# pull in changes
# ----------------------------------------------------------------------
echo "Getting changes"
git pull
echo "...done"

# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the ~/dotfiles directory
# specified in $files
# ----------------------------------------------------------------------
for file in $files; do
	echo "Removing any existing dotfiles from ~"
	rm ~/.$file
	echo "...done"
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "...all done"