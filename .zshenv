# This file is loaded first by zsh in a new session where ZDOTDIR hasn't been
# set, but will not be loaded if ZDOTDIR has already been configured
# To handle both cases, simply set ZDOTDIR and load the real zshenv
ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh
[ -r "$ZDOTDIR"/.zshenv ] && source "$ZDOTDIR"/.zshenv
