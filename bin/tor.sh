#!/usr/bin/env bash
#
# ######################################################################
# Start Tor and switch the system-wide proxy settings in OS X
# ----------------------------------------------------------------------
# Usage:
# just run tor.sh in Terminal, kill with ctrl + c
# ----------------------------------------------------------------------
# loosely based on
# http://leonid.shevtsov.me/en/an-easy-way-to-use-tor-on-os-x
# ######################################################################

# 'Wi-Fi' or 'Ethernet' or 'Display Ethernet'
INTERFACE=Wi-Fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Let's roll
sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
sudo networksetup -setsocksfirewallproxystate $INTERFACE on
tor
sudo networksetup -setsocksfirewallproxystate $INTERFACE off
