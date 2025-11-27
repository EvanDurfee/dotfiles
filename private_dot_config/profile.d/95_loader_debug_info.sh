_dotfiles_loader_shell="$(ps -cp "$$" -o command="")"
_dotfiles_loader_interactive="$([[ $- == *i* ]] && echo interactive || echo non-interactive)"
_dotfiles_loader_login="unkown_login"
if [ "$_dotfiles_loader_shell" = "zsh" ]; then
	_dotfiles_loader_login="$([[ -o login ]] && echo login shell || echo non-login shell)"
elif [ "$_dotfiles_loader_shell" = "bash" ]; then
	_dotfiles_loader_login="$(shopt -q login_shell && echo login shell || echo non-login shell)"
fi
export DOTFILES_PROFILE_LOADER="$_dotfiles_loader_shell $_dotfiles_loader_interactive $_dotfiles_loader_login"
export DOTFILES_PROFILE_LOADED=true

unset _dotfiles_loader_shell _dotfiles_loader_interactive _dotfiles_loader_login
