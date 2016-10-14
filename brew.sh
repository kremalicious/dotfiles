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
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

brew install git
brew install node
brew install wget
brew install gpg2
brew install imagemagick
brew install GraphicsMagick
brew install tor
brew install gsl

# Link gpg to gpg2
ln -s /usr/local/bin/gpg2 /usr/local/bin/gpg

# Remove outdated versions from the cellar.
brew cleanup
