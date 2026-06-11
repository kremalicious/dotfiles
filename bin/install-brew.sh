#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make `brew` available on PATH for the rest of this script
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install everything declared in the Brewfile
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# Remove outdated versions from the cellar.
brew cleanup
