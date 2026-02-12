# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="catppuccin"

# Case-sensitive completion
CASE_SENSITIVE="true"

# Plugins can be found in $ZSH/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Temporary fix to get the git prompt back
# https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#disable-async-git-prompt
zstyle ':omz:alpha:lib:git' async-prompt no

# Run the basic oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# If .profile is present, source it
[[ -e $HOME/.profile ]] && source $HOME/.profile

# Make neovim the default text editor on the system
export VISUAL="nvim"
export EDITOR="$VISUAL"

# Setup the NVM environment
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Source kubectl completions
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion zsh)
fi

# Add Golang binary to path
export PATH="$PATH:/usr/local/go/bin"

# pnpm
export PNPM_HOME="/home/clement/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
