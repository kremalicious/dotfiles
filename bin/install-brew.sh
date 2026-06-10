#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make `brew` available on PATH for the rest of this script
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install what we need
brew install \
    coreutils \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    git \
    wget \
    gpg \
    fnm \
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
