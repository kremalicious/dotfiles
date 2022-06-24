#!/bin/bash

# give me /usr/local first
#sudo chown -R "$USER" /usr/local

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install what we need
brew install \
    coreutils \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    git \
    wget \
    gpg \
    nvm \
    pinentry-mac \
    openssl \
    tor \
    pure \
    python \
    rclone \
    rsync \
    shellcheck \
    ipfs \
    clamav

# Remove outdated versions from the cellar.
brew cleanup
