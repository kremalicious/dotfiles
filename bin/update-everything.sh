#!/usr/bin/env bash


#
# macOS
# -------------

"$(tput setaf 136)"
echo "Update macOS Apps               "
echo "------------------------------"
"$(tput sgr0)" # reset

#sudo softwareupdate -i -a

mas upgrade

#
# Homebrew
# -------------

"$(tput setaf 136)"
echo "Update Homebrew               "
echo "------------------------------"
"$(tput sgr0)" # reset

brew update
brew upgrade
brew cleanup


#
# npm
# -------------

"$(tput setaf 136)"
echo "Update npm                   "
echo "------------------------------"
"$(tput sgr0)" # reset

# update npm itself
npm install npm -g

# update all global packages
npm update -g

#
# Ruby
# -------------

"$(tput setaf 136)"
echo "Update rvm                   "
echo "------------------------------"
"$(tput sgr0)" # reset

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

"$(tput setaf 136)"
echo "Refresh GPG keys              "
echo "------------------------------"
"$(tput sgr0)" # reset

gpg --refresh-keys

"$(tput setaf 64)" # green
echo "-------------------------------"
echo " ✓ all done"
"$(tput sgr0)" # reset
