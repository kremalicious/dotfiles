# dotfiles

> 👩‍🎤 personal dotfiles, scrambled together from the interwebz. Highly macOS oriented, with zsh, Homebrew.

[![Build Status](https://github.com/kremalicious/dotfiles/workflows/CI/badge.svg)](https://github.com/kremalicious/dotfiles/actions)

![hackerman](https://cloud.githubusercontent.com/assets/90316/26279873/9240a9d8-3dc0-11e7-9353-783b36ae6aff.jpg)

## Installation

### macOS

Full setup with Homebrew, zsh plugins, and all dotfiles:

```bash
git clone git@github.com:kremalicious/dotfiles.git
cd dotfiles
./bin/install.sh
```

### Linux

Minimal setup (zsh, git, vim only):

```bash
git clone git@github.com:kremalicious/dotfiles.git
cd dotfiles
./bin/install-linux.sh
```

## Update

Will update the symlinked dotfiles, useful if new dotfiles have been added:

```bash
git pull
./bin/update-dotfiles.sh
```

## Custom scripts

| Script                 | Description                                                                                                                                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `colors.sh`            | print out all available colors with their values in the Terminal                                                                                       |
| `tor.sh`               | start Tor and switch the system-wide proxy settings in macOS. [More info](https://kremalicious.com/simple-tor-setup-on-mac-os-x/)                      |
| `updaterepos.sh`       | recursively updates all git repositories within the given folder                                                                                       |
| `update-everything.sh` | update macOS, Mac App Store apps, Homebrew packages, (global) npm packages, Ruby via rvm, and refresh GPG keys all in one command. Aliased to `update` |
