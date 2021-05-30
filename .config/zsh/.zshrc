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

# Set the location for our zsh plugin downloads
zstyle ':znap:*' plugins-dir "$XDG_DATA_HOME"/znap
# automatically compile loaded zsh files
zstyle ':znap:*' auto-compile yes
# Load znap for plugin management
source "$HOME"/.local/src/zsh-snap/znap.zsh

# Load the actual prompt
znap source romkatv/powerlevel10k

# Prepare the LS_COLORS variable (clear the cache if changing the config)
znap eval dircolors 'dircolors -b "$XDG_CONFIG_HOME/dircolors/colors.conf"'

## General Options
# setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
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
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/cache
zstyle ':completion:*' menu select                              # enable menu style completions

# History
setopt append_history                                           # append history instead of overwriting
setopt extended_history                                         # save timestamp and duration to history
# setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt inc_append_history_time                                  # Like inc_append_history, but saves after the command completes so that execution time is correct with extended history
setopt hist_reduce_blanks                                       # remove superfluous blanks
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
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# bindkey '' send-break                                         # <?> to cancel tab-completion menu



## Theming
autoload -U colors zcalc
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R



## Plugins section

# Ideas:
# zsh-edit (adds hotkeys for going forwar / back dirs, binding hotkeys to commands... but some other stuff I don't like)
# autosuggestions (suggest completion for last matching command in history)
# fast-syntax-highlighting (faster syntax highlighting,theme options. Any catch?)=

# Load additional completions
znap source zsh-users/zsh-completions

# Fish style inline suggestions. Defaults to latest matching history, but can also use completions
znap source zsh-users/zsh-autosuggestions

# Adds clipboard functions (pbcopy, pbpaste, and clip) for interacting with system clipboard (works for Windows, Mac, X, Wayland...).
znap source zpm-zsh/clipboard

# Adds automatic enviornment loading and unloading (including functions, etc.)
znap source https://github.com/Tarrasch/zsh-autoenv

# Adds the ability to customize the 256 basic terminal colors
znap source chriskempson/base16-shell

# DISABLED: serious errors with parsing some flags (e.g. interprets --verbose as --shred).
# Adds a prompt to rm when deleting 3+ files, and allows recycling instead of de-indexing with the -c flag
# add ~/.rm_recycle_home to default to recyling any files rm'd in your home
# znap source MikeDacre/careful_rm
# touch ~/.rm_recycle_home

# Adds a function and widget for searching history with fuzzy matching
znap source evandurfee/zsh-fzf-history-search
bindkey '^r' fzf-history-search

# TODO: how does this compare to fast-syntax-highlighting?
# Use syntax highlighting (Note: wants to be after anything that modifies the line buffer)
znap source zsh-users/zsh-syntax-highlighting

# History substring search (must come after syntax highligting)
znap source zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



## Load aliases
if [ -f "${ZDOTDIR-$HOME/.config/zsh}/.zsh_aliases" ]; then
	source "${ZDOTDIR-$HOME/.config/zsh}/.zsh_aliases"
fi

# Add functions dir to fpath and load them
fpath=( "${ZDOTDIR-$HOME/.config/zsh}/functions" "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# Set up completions
autoload -U compinit && compinit -d

## Set terminal title
# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
	emulate -L zsh
	setopt prompt_subst

	[[ "$EMACS" == *term* ]] && return

	# if $2 is unset use $1 as default
	# if it is set and empty, leave it as is
	: ${2=$1}

	case "$TERM" in
		xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
			print -Pn "\e]2;${2:q}\a" # set window name
			print -Pn "\e]1;${1:q}\a" # set tab name
			;;
		screen*|tmux*)
			print -Pn "\ek${1:q}\e\\" # set screen hardstatus
			;;
		*)
		# Try to use terminfo to set the title
		# If the feature is available set title
		if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
			echoti tsl
			print -Pn "$1"
			echoti fsl
		fi
			;;
	esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
	[[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
	title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
	[[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

	emulate -L zsh

	# split command into array of arguments
	local -a cmdargs
	cmdargs=("${(z)2}")
	# if running fg, extract the command from the job description
	if [[ "${cmdargs[1]}" = fg ]]; then
		# get the job id from the first argument passed to the fg command
		local job_id jobspec="${cmdargs[2]#%}"
		# logic based on jobs arguments:
		# http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
		# https://www.zsh.org/mla/users/2007/msg00704.html
		case "$jobspec" in
			<->) # %number argument:
				# use the same <number> passed as an argument
				job_id=${jobspec} ;;
			""|%|+) # empty, %% or %+ argument:
				# use the current job, which appears with a + in $jobstates:
				# suspended:+:5071=suspended (tty output)
				job_id=${(k)jobstates[(r)*:+:*]} ;;
			-) # %- argument:
				# use the previous job, which appears with a - in $jobstates:
				# suspended:-:6493=suspended (signal)
				job_id=${(k)jobstates[(r)*:-:*]} ;;
			[?]*) # %?string argument:
				# use $jobtexts to match for a job whose command *contains* <string>
				job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
			*) # %string argument:
				# use $jobtexts to match for a job whose command *starts with* <string>
				job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
		esac

		# override preexec function arguments with job command
		if [[ -n "${jobtexts[$job_id]}" ]]; then
			1="${jobtexts[$job_id]}"
			2="${jobtexts[$job_id]}"
		fi
	fi

	# cmd name only, or if this is sudo or ssh, the next cmd
	local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
	local LINE="${2:gs/%/%%}"

	title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec

## VTE fix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi