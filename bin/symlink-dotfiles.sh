#!/usr/bin/env bash
#
# Symlink dotfiles into the home directory.
# Callers can override the FILES list, see install-linux.sh
#
# adapted from @mathiasbynens & @michaeljsmalley
# https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# colors only when stdout is a terminal
if [ -t 1 ] && [ -n "${TERM:-}" ]; then
    GREEN=$(tput setaf 64) CYAN=$(tput setaf 37) RESET=$(tput sgr0)
else
    GREEN="" CYAN="" RESET=""
fi

# list of files/folders to symlink in homedir
FILES="${FILES:-aliases exports private zshrc gitconfig gitconfig.macos gitignore hushlogin bin tmux.conf vimrc}"

# create the private file first, will be symlinked but ignored by git
touch "$DOTFILES_DIR/private"

for FILE in $FILES; do

    # remove old symlinks and regular files if present
    if [ -h "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "${GREEN}✓${RESET} Removed old symlink to ${CYAN}$FILE${RESET}"
    elif [ -f "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "${GREEN}✓${RESET} Removed old file ${CYAN}$FILE${RESET}"
    elif [ -e "$HOME/.$FILE" ]; then
        echo "⚠ Skipping $FILE: $HOME/.$FILE exists and is not a file or symlink"
        continue
    fi

    # symlink files
    ln -s "$DOTFILES_DIR/$FILE" "$HOME/.$FILE"
    echo "${GREEN}✓${RESET} Created new symlink to ${CYAN}$FILE${RESET}"

done
