# Load the common profile
if [[ -e ~/.profile ]]; then
  . ~/.profile
fi

# If the shell is interactive and bashrc exists, load it
if [[ $- == *i* && -f ~/.bashrc ]]; then
    . ~/.bashrc
fi
