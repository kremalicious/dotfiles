#!/bin/bash

# give me /usr/local first
#sudo chown -R "$USER" /usr/local

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install what we need
brew install \
    coreutils \
    bash \
    bash-completion2

# Switch to using brew-installed bash as default shell
if ! grep -F -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

brew install \
    git \
    node \
    wget \
    gpg \
    nvm \
    pandoc \
    pinentry-mac \
    openssl \
    tor \
    python \
    rclone \
    rsync \
    ruby \
    shellcheck \
    ipfs \
    clamav

# Remove outdated versions from the cellar.
brew cleanup
