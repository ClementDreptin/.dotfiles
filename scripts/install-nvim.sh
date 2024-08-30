#!/bin/bash

GIT_DIR="$(git rev-parse --show-toplevel)"
USER_BIN_DIR=$HOME/.local/bin
USER_CFG_DIR=$HOME/.config
NVIM_BIN=$USER_BIN_DIR/nvim
NVIM_CFG_DIR=$USER_CFG_DIR/nvim

# Download Neovim binary from GitHub and make it executable
echo "Installing Neovim..."
curl -Lo $NVIM_BIN https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x $NVIM_BIN

echo "Installing Neovim config..."

# Install Neovim config (symlink the config from the repo to right place)
ln -sfn $GIT_DIR/nvim $NVIM_CFG_DIR
