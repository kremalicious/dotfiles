#!/bin/bash

#
# OS X
# -------------

sudo softwareupdate -i -a

#
# Homebrew
# -------------

brew update
brew upgrade
brew cleanup


#
# npm
# -------------

# update npm itself
npm update npm -g

# update all global packages
#npm update -g
sh npm-upgrade.sh


#
# Ruby
# -------------
rvm get branch master
rvm cleanup all


#
# Gems
# -------------
gem update --system
gem update