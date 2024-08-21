#!/bin/bash

set -e

GIT_DIR="$(git rev-parse --show-toplevel)"
ZSH_HOME=$HOME/.oh-my-zsh
ZSH_CUSTOM=$ZSH_HOME/custom

echo "Installing zsh (apt)..."
sudo apt install zsh

# Install .zshrc
zshrc_src=$GIT_DIR/terminal/.zshrc
zshrc_dest=$HOME/.zshrc
echo "Installing .zshrc..."
echo "$zshrc_src --> $zshrc_dest"
ln -sf $zshrc_src $zshrc_dest

# Remove oh-my-zsh directory if it already exists
if [ -d $ZSH_HOME ]; then
  echo "oh-my-zsh already installed, removing old version..."
  rm -rf $ZSH_HOME
fi

# Install oh-my-zsh without overwriting our .zshrc,
# we don't run it immediately because the plugins are not installed yet
export KEEP_ZSHRC=yes
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install our custom catppuccin theme
catppuccin_theme_src=$GIT_DIR/terminal/catppuccin.zsh-theme
catppuccin_theme_dest=$ZSH_CUSTOM/themes/catppuccin.zsh-theme
echo "Installing catppuccin theme..."
echo "$catppuccin_theme_src --> $catppuccin_theme_dest"
ln -sf $catppuccin_theme_src $catppuccin_theme_dest

# Install plugins if needed
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in ${plugins[@]}; do
  plugin_path=$ZSH_CUSTOM/plugins/$plugin
  if [ ! -d $plugin_path ]; then
    echo "Installing $plugin..."
    git clone https://github.com/zsh-users/$plugin $plugin_path
  fi
done

# Make zsh the default shell
echo "Making zsh the default shell..."
chsh -s $(which zsh)

# Run zsh
zsh
