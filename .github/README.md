# Dotfiles

## Usage

```shell
# Clone the git repo to ~/.home
git clone --bare git@github.com:EvanDurfee/.home.git $HOME/.home
# Set up an alias to work with the repo
alias cfg='/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME'
# checkout the changes
cfg checkout
# You'll need to remove / backup any conflicting files before checkout will succeed
# NOTE: you'll need to set permissions for the configs, as everything defaults to rw-rw-r--
```
