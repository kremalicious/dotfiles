#!/bin/bash

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

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