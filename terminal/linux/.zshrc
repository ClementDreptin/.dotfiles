# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Case-sensitive completion
CASE_SENSITIVE="true"

# Plugins can be found in $ZSH/plugins/
plugins=(git nvm)

# Run the basic oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# Use oh-my-posh for the themes instead of oh-my-zsh
POSH_THEME="aliens"
POSH_THEMES_PATH="$HOME/.poshthemes"
eval "$(oh-my-posh init zsh --config $POSH_THEMES_PATH/$POSH_THEME.omp.json)"

# If .profile is present, source it
[[ -e $HOME/.profile ]] && emulate sh -c 'source $HOME/.profile'
