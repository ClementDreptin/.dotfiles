#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin

# Create the user's private bin directory if needed
if [ ! -d $USER_BIN_DIR ]; then
  echo "Private bin directory ($USER_BIN_DIR) not found, creating..."
  mkdir -p $USER_BIN_DIR
fi

echo "Installing lazygit..."

lazygit_version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
lazygit_tar=lazygit.tar.gz
curl -Lo $lazygit_tar "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
tar xf $lazygit_tar lazygit
rm $lazygit_tar
mv lazygit $USER_BIN_DIR/lazygit
