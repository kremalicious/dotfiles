#!/usr/bin/env bash

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
# Bun packages
# -------------

echo ""
echo ""
echo "$(tput setaf 3) Update Global Bun packages"
echo "------------------------------$(tput sgr0)"

bun update -g

#
# ClamAV
# -------------

# echo ""
# echo ""
# echo "$(tput setaf 3) Update ClamAV Database"
# echo "------------------------------$(tput sgr0)"

# freshclam -v


#
# GPG
# -------------

# echo ""
# echo ""
# echo "$(tput setaf 3) Refresh GPG keys"
# echo "------------------------------$(tput sgr0)"

# gpg --refresh-keys

# echo ""
# echo "$(tput setaf 2) -------------------------------"
# echo " ✓ all done$(tput sgr0)"
