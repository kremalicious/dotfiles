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
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
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
