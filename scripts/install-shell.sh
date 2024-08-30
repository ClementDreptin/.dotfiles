#!/bin/bash

set -e

GIT_DIR="$(git rev-parse --show-toplevel)"
OMZ_DIR=$HOME/.oh-my-zsh
OMZ_CUSTOM_DIR=$OMZ_DIR/custom

echo "Installing zsh (apt)..."
sudo apt install zsh

# Install .zshrc
zshrc_src=$GIT_DIR/terminal/.zshrc
zshrc_dest=$HOME/.zshrc
echo "Installing .zshrc..."
echo "$zshrc_src --> $zshrc_dest"
ln -sf $zshrc_src $zshrc_dest

# Remove oh-my-zsh directory if it already exists
if [ -d $OMZ_DIR ]; then
  echo "oh-my-zsh already installed, removing old version..."
  rm -rf $OMZ_DIR
fi

# Install oh-my-zsh without overwriting our .zshrc,
# we don't run it immediately because the plugins are not installed yet
export KEEP_ZSHRC=yes
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install our custom catppuccin theme
catppuccin_theme_src=$GIT_DIR/terminal/catppuccin.zsh-theme
catppuccin_theme_dest=$OMZ_CUSTOM_DIR/themes/catppuccin.zsh-theme
echo "Installing catppuccin theme..."
echo "$catppuccin_theme_src --> $catppuccin_theme_dest"
ln -sf $catppuccin_theme_src $catppuccin_theme_dest

# Install plugins if needed
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in ${plugins[@]}; do
  plugin_path=$OMZ_CUSTOM_DIR/plugins/$plugin
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
