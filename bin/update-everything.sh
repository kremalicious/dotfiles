#!/bin/bash


#
# OS X
# -------------

#sudo softwareupdate -i -a

#
# Homebrew
# -------------

echo "$(tput setaf 136)"
echo "               Update Homebrew               "
echo "============================================="
echo "$(tput sgr0)" # reset

brew update
brew upgrade
brew cleanup

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset

#
# npm
# -------------

echo "$(tput setaf 136)"
echo "                Update npm                   "
echo "============================================="
echo "$(tput sgr0)" # reset

# update npm itself
npm install npm -g

# update all global packages
#npm update -g
sh npm-upgrade.sh

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset

#
# Ruby
# -------------

echo "$(tput setaf 136)"
echo "                Update rvm                   "
echo "============================================="
echo "$(tput sgr0)" # reset

# update rvm itself
rvm get latest
rvm cleanup all

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset

#
# Gems
# -------------

echo "$(tput setaf 136)"
echo "                Update gems                  "
echo "============================================="
echo "$(tput sgr0)" # reset

gem update --system
gem update

echo "$(tput setaf 64)" # green
echo "---------------------------------------------"
echo "                 ✓ done"
echo "$(tput sgr0)" # reset