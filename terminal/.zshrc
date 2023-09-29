# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="catppuccin"

# Case-sensitive completion
CASE_SENSITIVE="true"

# Plugins can be found in $ZSH/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Run the basic oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# If .profile is present, source it
[[ -e $HOME/.profile ]] && emulate sh -c 'source $HOME/.profile'

# Make neovim the default text editor on the system
export VISUAL="nvim"
export EDITOR="$VISUAL"

# Setup the volta environment
export VOLTA_HOME=$HOME/.volta
export PATH=$VOLTA_HOME/bin:$PATH
