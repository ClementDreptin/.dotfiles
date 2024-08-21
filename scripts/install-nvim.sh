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

# Install the Neovim binary if needed
if [ ! -f $NVIM_BIN ]; then
  # Install libfuse2 if needed (required to run AppImages)
  dpkg -s libfuse2 >/dev/null 2>&1
  if [ ! $? -eq 0 ]; then
    echo "libfuse2 is required to run AppImages and was not found, installing..."
    sudo apt install libfuse2
  fi

  # Download Neovim binary from GitHub and make it executable
  echo "Neovim binary not found, installing..."
  curl -Lo $NVIM_BIN https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x $NVIM_BIN
fi

# Install Neovim config if needed
if [ ! -d $NVIM_CFG ]; then
  echo "Installing Neovim config..."

  # Create the user config directory if needed
  if [ ! -d $USER_CFG ]; then
    mkdir -p $USER_CFG
  fi

  ln -s $GIT_DIR/nvim $NVIM_CFG
fi

# Install the Neovim plugins' system dependencies if needed
deps=(ripgrep build-essential zip)
for dep in ${deps[@]}; do
  dpkg -s $dep >/dev/null 2>&1
  if [ ! $? -eq 0 ]; then
    echo "$dep is required and was not found, installing..."
    sudo apt install $dep
  fi
done
