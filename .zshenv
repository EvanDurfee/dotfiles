# This file is loaded first by zsh in a new session where ZDOTDIR hasn't been
# set, but will not be loaded if ZDOTDIR has already been configured
# To handle both cases, simply set ZDOTDIR and load the real zshenv

# Stop compinit on ubuntu & derivatives
skip_global_compinit=1

ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh
[ -r "$ZDOTDIR"/.zshenv ] && source "$ZDOTDIR"/.zshenv
