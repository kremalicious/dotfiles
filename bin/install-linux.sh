#!/usr/bin/env bash
#
# Minimal dotfiles installer for Linux systems
########################################################################

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing dotfiles..."
echo "---------------------------------------------"

# Minimal list of files for Linux
FILES="aliases exports zshrc gitconfig gitignore vimrc" \
    "$DOTFILES_DIR/bin/symlink-dotfiles.sh"

# ----------------------------------------------------------------------
# Install Pure prompt, picked up via fpath in zshrc
# https://github.com/sindresorhus/pure#manually
# ----------------------------------------------------------------------

echo "---------------------------------------------"
echo "Installing Pure prompt..."

PURE_DIR="$HOME/.zsh/pure"

if [ -d "$PURE_DIR/.git" ]; then
    (cd "$PURE_DIR" && git pull --quiet)
    echo "✓ Updated Pure prompt in $PURE_DIR"
else
    mkdir -p "$HOME/.zsh"
    git clone --quiet https://github.com/sindresorhus/pure.git "$PURE_DIR"
    echo "✓ Installed Pure prompt to $PURE_DIR"
fi

# ----------------------------------------------------------------------
# Set zsh as default shell (skip in non-interactive/devcontainer)
# ----------------------------------------------------------------------

echo "---------------------------------------------"

if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH=$(command -v zsh)
    echo "✓ zsh found at $ZSH_PATH"

    if [ "$SHELL" != "$ZSH_PATH" ]; then
        echo "  To set as default: chsh -s $ZSH_PATH"
    fi
else
    echo "⚠ zsh not found, install it first (apt install zsh)"
fi

echo "---------------------------------------------"
echo "✓ Linux dotfiles installed"
