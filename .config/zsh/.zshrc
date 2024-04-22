# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

if [ -z "$XDG_DATA_HOME" ] || [ -z "$XDG_CONFIG_HOME" ]; then
	echo "XDG dirs unset, something is wrong!"
	return 1
fi

# Add named directory zsh
hash -d zsh="$ZDOTDIR"

# Set the location for our zsh plugin downloads
zstyle ':znap:*' plugins-dir "$XDG_DATA_HOME"/zsh-snap
# automatically compile loaded zsh files
zstyle ':znap:*' auto-compile yes
# Disable auto git mainenance
zstyle ':znap:*' git-maintenance off

# Install the ZSH plugin manager
if [ ! -d "$XDG_DATA_HOME"/zsh-snap/zsh-snap ]; then
	mkdir -p "$XDG_DATA_HOME"/zsh-snap/
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git "$XDG_DATA_HOME"/zsh-snap/zsh-snap
fi

# Load znap for plugin management
source "$XDG_DATA_HOME"/zsh-snap/zsh-snap/znap.zsh

# Load the actual prompt
znap source romkatv/powerlevel10k

# Prepare the LS_COLORS variable (clear the cache if changing the config)
znap eval dircolors 'dircolors -b "$XDG_CONFIG_HOME/dircolors/colors.conf"'
# znap eval dircolors 'dircolors -b "$XDG_CONFIG_HOME/dircolors/trapd00r_LS_COLORS.conf"'


# If running kitty terminal, add integration
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-cursor"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

## General Options
# setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt interactivecomments                                      # Interpet # as a comment in interactive shells
# setopt nocaseglob                                               # Case insensitive globbing
# setopt nomatch                                                  # return a non-zero status if no results match the pattern
# setopt completealiases                                          # disables!? autocompletion for aliases
setopt rcexpandparam                                            # Array expansion with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep


WORDCHARS=${WORDCHARS//[\/;]}                                   # Don't consider / or ; as wordchars
autoload -U select-word-style
select-word-style normal                                        # Set to "bash" to ignore WORDCHARS and use only alphanumerics

# Completions
zstyle ':completion:*' completer _complete                      # Do not expand variables while completing
# zstyle ':completion:*' completer _expand _complete              # If present, expand the variable under the cursor instead of completing
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR"/cache
zstyle ':completion:*' menu select                              # enable menu style completions

# History
# setopt append_history                                           # append history instead of overwriting
setopt extended_history                                         # save timestamp and duration to history
# setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt inc_append_history_time                                  # Like inc_append_history, but saves after the command completes so that execution time is correct with extended history
setopt hist_reduce_blanks                                       # remove superfluous blanks
# setopt hist_ignore_dups                                         # Don't add to history if this command is the same as the previous
# setopt hist_find_no_dups                                        # When searching back through history, skip duplicates
setopt hist_ignore_all_dups                                     # If a new command is a duplicate, remove the older one

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
if [ ! -f "$HISTFILE" ]; then
	mkdir -p "$HISTFILE:h" && touch "$HISTFILE" && chmod 600 "$HISTFILE"
fi
HISTSIZE=10000
SAVEHIST=10000

# Changing Directories
setopt auto_cd                                                  # if only directory path is entered, cd there.
# Sets cd to behave like pushd (allows cd -[n] or cd +[n] to navigate the stack)
# Use cd -<TAB> or cd +<TAB> to show the stack
setopt auto_pushd                                               # Make cd push the old directory onto the dir stack
setopt pushd_silent                                             # Do not print the directory stack after pushd or popd
setopt pushd_to_home                                            # pushd with no args acts like pushd $HOME
setopt pushd_ignore_dups                                        # Don't push multiple copies of the same dir
setopt pushd_minus                                              # Swap meaning of + and - (- will index from the top of the stack, + from the bottom)
DIRSTACKSIZE=20




## Keybindings
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
	bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
	bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^?' backward-delete-char                               # Backspace key

bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[OA' up-line-or-history                               # Up
bindkey '^[OB' down-line-or-history                             # Down

bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     # Ctrl+right
bindkey '^[Od' backward-word                                    # Ctrl+left
bindkey '^[[1;5D' backward-word                                 # Ctrl+left
bindkey '^[[1;5C' forward-word                                  # Ctrl+right


bindkey '^[[3;5~' kill-word                                     # delete next word with ctrl+delete
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
# bindkey '^[[Z' undo                                             # Shift+tab undo last action
bindkey '^[[Z' reverse-menu-complete                            # Shift+tab to jump to the previous completiong


## Theming
autoload -U colors zcalc
colors

## Plugins section

# Ideas:
# zsh-edit (adds hotkeys for going forwar / back dirs, binding hotkeys to commands... but some other stuff I don't like)
# fast-syntax-highlighting (faster syntax highlighting,theme options. Any catch?)=

# fzf tab completion (completions | fzf)
# znap source Aloxaf/fzf-tab
# Hotkey to accept query input instead of a suggestion
# zstyle ':fzf-tab:*' print-query alt-enter

# fsf tab completion (fzf | completion)
# znap source lincheney/fzf-tab-completion

# Load additional completions
znap source zsh-users/zsh-completions

# Fish style inline suggestions. Defaults to latest matching history, but can also use completions
znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# Only use match_prev_cmd if history order is preserved
# ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)
ZSH_AUTOSUGGEST_STRATEGY=(history)

# Adds clipboard functions (pbcopy, pbpaste, and clip) for interacting with system clipboard (works for Windows, Mac, X, Wayland...).
# Removed in favor of custom clip script
# znap source zpm-zsh/clipboard

# Adds automatic enviornment loading and unloading (including functions, etc.)
znap source Tarrasch/zsh-autoenv

# Adds the ability to customize the 256 basic terminal colors
znap source chriskempson/base16-shell

# DISABLED: serious errors with parsing some flags (e.g. interprets --verbose as --shred).
# Adds a prompt to rm when deleting 3+ files, and allows recycling instead of de-indexing with the -c flag
# add ~/.rm_recycle_home to default to recyling any files rm'd in your home
# znap source MikeDacre/careful_rm
# touch ~/.rm_recycle_home

# Adds a function and widget for searching history with fuzzy matching

# My fork (currently disabled)
# znap source evandurfee/zsh-fzf-history-search
# bindkey '^r' fzf-history-search

znap source joshskidmore/zsh-fzf-history-search

# Use syntax highlighting (Note: wants to be after anything that modifies the line buffer)
znap source zsh-users/zsh-syntax-highlighting

# History substring search (must come after syntax highligting)
znap source zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## Load aliases
if [ -f "${ZDOTDIR:-$HOME}/.zaliases" ]; then
	source "${ZDOTDIR:-$HOME}/.zaliases"
fi

# Add functions dir to fpath and load them
fpath=( "${ZDOTDIR:-$HOME}/functions" "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Add ubuntu completions path
# docker is hardcoded to use this even on fedora
if [ -d /usr/share/zsh/vendor-completions ]; then
	fpath=( /usr/share/zsh/vendor-completions "${fpath[@]}" )
	autoload -Uz $fpath[1]/*(.:t)
fi

# Zoxide hooks
if hash zoxide 2>/dev/null; then
	znap eval zoxide 'zoxide init --cmd cd zsh'
fi

## Cache completions if the applications are present
if hash kubectl 2>/dev/null; then
	znap fpath _kubectl 'kubectl completion zsh'
fi
if hash helm 2>/dev/null; then
	znap fpath _helm    'helm completion zsh'
fi
if hash rustup 2>/dev/null; then
	znap fpath _rustup  'rustup completions zsh'
	znap fpath _cargo   'rustup completions zsh cargo'
fi

## Load overrides
if [ -f "${ZDOTDIR:-$HOME}/.zoverride" ]; then
	source "${ZDOTDIR:-$HOME}/.zoverride"
fi

## Set terminal window and tab/icon title + pwd
source "${ZDOTDIR:-$HOME}/set_term_info.zsh"

## VTE fix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

