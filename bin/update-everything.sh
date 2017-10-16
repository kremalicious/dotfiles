#!/usr/bin/env bash


#
# macOS
# -------------

echo ""
echo "$(tput setaf 3) Update macOS Apps"
echo "------------------------------$(tput sgr0)"

#sudo softwareupdate -i -a

mas upgrade

#
# Homebrew
# -------------

echo ""
echo ""
echo "$(tput setaf 3) Update Homebrew"
echo "------------------------------$(tput sgr0)"

brew update
brew upgrade
brew cleanup


#
# npm
# -------------

echo ""
echo ""
echo "$(tput setaf 3) Update npm"
echo "------------------------------$(tput sgr0)"

# update npm itself
npm install npm -g

# update all global packages
npm update -g



#
# Ruby
# -------------

echo ""
echo ""
echo "$(tput setaf 3) Update rvm"
echo "------------------------------$(tput sgr0)"

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

echo ""
echo ""
echo "$(tput setaf 3) Refresh GPG keys"
echo "------------------------------$(tput sgr0)"

gpg --refresh-keys

echo ""
echo "$(tput setaf 2) -------------------------------"
echo " ✓ all done$(tput sgr0)"
