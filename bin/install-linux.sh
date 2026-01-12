#!/usr/bin/env bash
#
# Minimal dotfiles installer for Linux systems
########################################################################

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Minimal list of files for Linux
FILES="aliases exports zshrc gitconfig gitignore vimrc"

cd "$DOTFILES_DIR"

echo "Installing dotfiles..."
echo "---------------------------------------------"

for FILE in $FILES; do
    # remove old symlinks if present
    if [ -h "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "✓ Removed old symlink to $FILE"
    fi

    # remove regular files too (in case they exist)
    if [ -f "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "✓ Removed old file $FILE"
    fi

    # symlink files
    ln -s "$DOTFILES_DIR/$FILE" "$HOME/.$FILE"
    echo "✓ Created new symlink to $FILE"
done

# ----------------------------------------------------------------------
# Install Pure prompt (try npm, then bun)
# ----------------------------------------------------------------------

echo "---------------------------------------------"
echo "Installing Pure prompt..."

if command -v npm >/dev/null 2>&1; then
    npm install --global pure-prompt && echo "✓ Installed pure-prompt via npm" || echo "⚠ Failed to install pure-prompt via npm"
elif command -v bun >/dev/null 2>&1; then
    bun install --global pure-prompt && echo "✓ Installed pure-prompt via bun" || echo "⚠ Failed to install pure-prompt via bun"
else
    echo "⚠ Neither npm nor bun found, skipping pure-prompt install"
fi

# ----------------------------------------------------------------------
# Set zsh as default shell
# ----------------------------------------------------------------------

echo "---------------------------------------------"
echo "Setting up zsh..."

if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH=$(command -v zsh)

    # Change default shell
    if [ "$SHELL" != "$ZSH_PATH" ]; then
        chsh -s "$ZSH_PATH" && echo "✓ Set zsh as default shell" || echo "⚠ Failed to set zsh as default shell (try: chsh -s $ZSH_PATH)"
    else
        echo "✓ zsh is already the default shell"
    fi
else
    echo "⚠ zsh not found, install it first (apt install zsh)"
fi

echo "---------------------------------------------"
echo "✓ Linux dotfiles installed"
