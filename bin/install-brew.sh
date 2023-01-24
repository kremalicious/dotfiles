#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ $(uname -m) == 'arm64' ]]; then
  PATH_HOMEBREW=/opt/homebrew
else
  PATH_HOMEBREW=/usr/local
fi

# Install what we need
$PATH_HOMEBREW/bin/brew install \
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
$PATH_HOMEBREW/bin/brew cleanup
