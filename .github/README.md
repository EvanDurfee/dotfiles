# Dotfiles

## Installation

```shell
# Clone the git repo to ~/.home (ssh)
git clone --bare git@github.com:EvanDurfee/dotfiles.git $HOME/.local/share/dotfiles
# OR Clone the git repo to ~/.home (https / public)
git clone --bare https://github.com/EvanDurfee/dotfiles.git $HOME/.local/share/dotfiles
# Checkout the files into your home dir
# You'll need to remove / backup any conflicting files before checkout will succeed
git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME checkout
# Pull submodules
git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME submodule update --init --recursive
# NOTE: you'll need to set permissions for the configs, as defaults may be 
#  excessively permissive (e.g. rw-rw-r--)
chmod 700 $HOME/.local/share/dotfiles $HOME/.config
```

## Usage

Once zsh is loaded, the alias `cfg` can be used to add / remove dotfiles.
The alias `cfg-update` provides an easy way to pull updates for the main repo
and submodules. 

```shell
cfg add .config/nano/nanorc
cfg commit -m "Commit!" && cfg push
cfg-update # pull and update submodules
```
