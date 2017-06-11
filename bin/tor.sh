#!/usr/bin/env bash
#
# ######################################################################
# Start Tor and switch the system-wide proxy settings in OS X
# ----------------------------------------------------------------------
# Usage:
# just run tor.sh in Terminal, kill with ctrl + c
# ----------------------------------------------------------------------
# more info:
# https://kremalicious.com/simple-tor-setup-on-mac-os-x/
# ######################################################################

# 'Wi-Fi' or 'Ethernet' or 'Display Ethernet'
INTERFACE=Wi-Fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# trap ctrl-c and call disable_proxy()
function disable_proxy() {
    sudo networksetup -setsocksfirewallproxystate $INTERFACE off
    echo "$(tput setaf 64)SOCKS proxy disabled.$(tput sgr0)"
}
trap disable_proxy INT

# Let's roll
sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
sudo networksetup -setsocksfirewallproxystate $INTERFACE on

echo "$(tput setaf 64)SOCKS proxy 127.0.0.1:9050 enabled."
echo "$(tput setaf 136)Starting Tor...$(tput sgr0)"

tor
