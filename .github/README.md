# Dotfiles

## Usage

```shell
# Clone the git repo to ~/.home (ssh)
git clone --bare git@github.com:EvanDurfee/dotfiles.git $HOME/.local/share/dotfiles
# OR Clone the git repo to ~/.home (https / public)
git clone --bare https://github.com/EvanDurfee/dotfiles.git $HOME/.local/share/dotfiles
# Checkout the files into your home dir
# You'll need to remove / backup any conflicting files before checkout will succeed
git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME checkout
# NOTE: you'll need to set permissions for the configs, as everything defaults to rw-rw-r--
chmod 700 $HOME/.local/share/dotfiles $HOME/.config
```
