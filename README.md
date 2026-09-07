# Dotfiles

My dotfiles, managed by chezmoi

Migration from git bare repo is in progress

## Setup

### Pre-reqs

Linux system with homebrew and chezmoi installed.

### Config init

Initialize the chezmoi config.
Separate home and work profiles are supported, with different age encryption keys.

```shell
chezmoi init --ssh --branch=chezmoi evandurfee
chezmoi apply
```

## Manual steps

```shell
hostnamectl hostname <hostname>
# launch bitwarden flatpak and enable ssh agent
# Open syncthing and enable https + password
```

