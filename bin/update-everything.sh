#!/usr/bin/env bash


#
# OS X
# -------------

#sudo softwareupdate -i -a

#
# Homebrew
# -------------

echo "$(tput setaf 136)"
echo "Update Homebrew               "
echo "=============================="
echo "$(tput sgr0)" # reset

brew update
brew upgrade --all
brew cleanup


#
# npm
# -------------

echo "$(tput setaf 136)"
echo "Update npm                   "
echo "============================="
echo "$(tput sgr0)" # reset

# update npm itself
npm install npm -g

# update all global packages
npm update -g

#
# Ruby
# -------------

echo "$(tput setaf 136)"
echo "Update rvm                   "
echo "============================="
echo "$(tput sgr0)" # reset

# update rvm itself
rvm get stable
rvm reload

# update all gemsets
rvm gemset update

# cleanup
rvm cleanup all


echo "$(tput setaf 64)" # green
echo "-------------------------------"
echo " ✓ all done"
echo "$(tput sgr0)" # reset
