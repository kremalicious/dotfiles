#!/usr/bin/env bash


#
# macOS
# -------------

echo "$(tput setaf 136)"
echo "Update macOS Apps               "
echo "------------------------------"
echo "$(tput sgr0)" # reset

#sudo softwareupdate -i -a

mas upgrade

#
# Homebrew
# -------------

echo "$(tput setaf 136)"
echo "Update Homebrew               "
echo "------------------------------"
echo "$(tput sgr0)" # reset

brew update
brew upgrade
brew cleanup


#
# npm
# -------------

echo "$(tput setaf 136)"
echo "Update npm                   "
echo "------------------------------"
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
echo "------------------------------"
echo "$(tput sgr0)" # reset

# update rvm itself
rvm get stable
rvm reload

# update all gemsets
rvm gemset update

# cleanup
rvm cleanup all

#
# GPG
# -------------

echo "$(tput setaf 136)"
echo "Refresh GPG keys              "
echo "------------------------------"
echo "$(tput sgr0)" # reset

gpg --refresh-keys

echo "$(tput setaf 64)" # green
echo "-------------------------------"
echo " ✓ all done"
echo "$(tput sgr0)" # reset
