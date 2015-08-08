#!/bin/bash

# give me /usr/local first
sudo chown -R $USER /usr/local

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install what we need
brew install coreutils
brew install bash
brew install bash-completion
brew install git
brew install node
brew install wget
brew install gpg2
brew install mysql
brew install imagemagick
brew install GraphicsMagick
brew install android
brew install tor

# Link gpg to gpg2
ln -s /usr/local/bin/gpg2 /usr/local/bin/gpg

# Remove outdated versions from the cellar.
brew cleanup
