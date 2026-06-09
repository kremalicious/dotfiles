#!/usr/bin/env bash
#
# Full macOS setup: symlink all dotfiles, install Homebrew and packages,
# switch the default shell to brew-installed zsh
########################################################################

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# colors only when stdout is a terminal
if [ -t 1 ] && [ -n "${TERM:-}" ]; then
    YELLOW=$(tput setaf 136) GREEN=$(tput setaf 64) RESET=$(tput sgr0)
else
    YELLOW="" GREEN="" RESET=""
fi

# ----------------------------------------------------------------------
# Symlink dotfiles
# ----------------------------------------------------------------------

"$DOTFILES_DIR/bin/symlink-dotfiles.sh"

# ----------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------

echo "${YELLOW}           Brewing all the things. "
echo "=============================================${RESET}"

"$DOTFILES_DIR/bin/install-brew.sh"

echo "${GREEN}---------------------------------------------"
echo "                 ✓ done${RESET}"

# ----------------------------------------------------------------------
# Shell
# ----------------------------------------------------------------------

# Switch to using brew-installed zsh as default shell
zsh_path="$(/opt/homebrew/bin/brew --prefix)/bin/zsh"

if ! grep -F -q "$zsh_path" /etc/shells; then
    echo "$zsh_path" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$zsh_path" ]; then
    chsh -s "$zsh_path"
fi

echo "${GREEN}============================================="
echo "                 ✓ all done"
echo "=============================================${RESET}"
