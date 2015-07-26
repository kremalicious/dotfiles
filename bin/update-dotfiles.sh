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
dir=~/Projects/dotfiles

# list of files/folders to symlink in homedir
files="aliases bashrc bash_profile bash_paths bash_prompt exports gemrc gitconfig gitignore hushlogin inputrc private tm_properties npmrc bin"


# ----------------------------------------------------------------------
# change to the dotfiles directory
# ----------------------------------------------------------------------

cd $dir


# ----------------------------------------------------------------------
# pull in changes
# ----------------------------------------------------------------------

echo "$(tput setaf 136)"
echo "              Getting changes "
echo "============================================="
echo "$(tput sgr0)" # reset

#git pull

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset


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


echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ all done"
echo "$(tput sgr0)" # reset
