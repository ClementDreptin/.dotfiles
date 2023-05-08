# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="catppuccin"

# Case-sensitive completion
CASE_SENSITIVE="true"

# Plugins can be found in $ZSH/plugins/
plugins=(git nvm zsh-autosuggestions zsh-syntax-highlighting)

# Run the basic oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# If .profile is present, source it
[[ -e $HOME/.profile ]] && emulate sh -c 'source $HOME/.profile'
