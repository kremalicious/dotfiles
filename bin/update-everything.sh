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
# Node.js & npm (nvm)
# -------------

# echo ""
# echo ""
# echo "$(tput setaf 3) Update Node.js & npm (nvm)"
# echo "------------------------------$(tput sgr0)"

# # shellcheck source=/dev/null
# [ -s "$HOME/.nvm" ] && . "$HOME/.nvm/nvm.sh"

# # Update to latest nvm Node.js
# nvm install node --reinstall-packages-from=node
# nvm alias default node

# # update npm itself
# nvm install-latest-npm

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
