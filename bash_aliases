#!/usr/bin/env bash

# ----------------------------------------------------------------------
#  ALIASES
# ----------------------------------------------------------------------

alias ll='ls -la'

# Easier navigation: .., ..., ~
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

alias a='atom-beta .'
alias s='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl .'
alias c='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code .'

# Update All The Things
alias update='update-everything.sh'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"

# Copy SSH public key to pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '\$(tput setaf 64)✓ Public SSH key copied to pasteboard.\$(tput sgr0)\n'"

# Copy GPG public key to pasteboard
alias gpgpubkey="gpg --export --armor 0xDD7831FC | pbcopy | printf '\$(tput setaf 64)✓ Public GPG key copied to pasteboard.\$(tput sgr0)\n'"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool TRUE && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool FALSE && killall Finder"

# When there's need for nyaning around
alias nyan="telnet nyancat.dakko.us"

# Virus scan with ClamAV
alias virusscan="clamscan -r --bell -i /"

# Docker & Docker Compose
alias dc="docker-compose"
