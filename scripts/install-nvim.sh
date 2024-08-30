#!/bin/bash

GIT_DIR="$(git rev-parse --show-toplevel)"
USER_BIN_DIR=$HOME/.local/bin
USER_CFG=$HOME/.config
NVIM_BIN=$USER_BIN_DIR/nvim
NVIM_CFG=$USER_CFG/nvim

# Create the user's private bin directory if needed
if [ ! -d $USER_BIN_DIR ]; then
  echo "Private bin directory ($USER_BIN_DIR) not found, creating..."
  mkdir -p $USER_BIN_DIR
fi

# Download Neovim binary from GitHub and make it executable
echo "Installing Neovim..."
curl -Lo $NVIM_BIN https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x $NVIM_BIN

echo "Installing Neovim config..."

# Create the user config directory if needed
if [ ! -d $USER_CFG ]; then
  mkdir -p $USER_CFG
fi

# Install Neovim config (symlink the config from the repo to right place)
ln -sfn $GIT_DIR/nvim $NVIM_CFG
