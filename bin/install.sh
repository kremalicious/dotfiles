#!/usr/bin/env bash
#
# creates symlinks from the home directory to
# any desired dotfiles in ~/dotfiles
#
# adapted from @michaeljsmalley
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
########################################################################

set e

# list of files/folders to symlink in homedir
FILES="aliases exports private zshrc zprofile gitconfig gitignore hushlogin bin tmux.conf vimrc"

# ----------------------------------------------------------------------
# create the private file first, will be symlinked but ignored by git
# ----------------------------------------------------------------------

touch private

# ----------------------------------------------------------------------
# create symlinks from the homedir to any files in the dotfiles directory
# specified in $FILES
# ----------------------------------------------------------------------

for FILE in $FILES; do

    # remove old symlinks if present
    if [ -h "$HOME/.$FILE" ]; then
        rm "$HOME/.$FILE"
        echo "$(tput setaf 64)✓$(tput sgr0) Removed old symlink to $(tput setaf 37)$FILE$(tput sgr0)"
    fi

    # symlink files
    ln -s "$PWD/$FILE" "$HOME/.$FILE"
    echo "$(tput setaf 64)✓$(tput sgr0) Created new symlink to $(tput setaf 37)$FILE$(tput sgr0)"

done

# ----------------------------------------------------------------------
# Homebrew
# ----------------------------------------------------------------------

echo "$(tput setaf 136)           Brewing all the things. "
echo "=============================================$(tput sgr0)"
"" # reset

./bin/install-brew.sh

echo "$(tput setaf 64)---------------------------------------------"
echo "                 ✓ done$(tput sgr0)"

# ----------------------------------------------------------------------
# Prompt
# ----------------------------------------------------------------------

# Switch to using brew-installed zsh as default shell
if ! grep -F -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/zsh;
fi;

npm i -g pure-prompt

echo "$(tput setaf 64)============================================="
echo "                 ✓ all done"
echo "=============================================$(tput sgr0)"
