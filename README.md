# Dotfiles

My dotfiles, managed by chezmoi

Migration from git bare repo is in progress

## Setup

Install homebrew and chezmoi first

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

