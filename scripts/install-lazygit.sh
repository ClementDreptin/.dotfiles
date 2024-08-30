#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin

echo "Installing lazygit..."

# Download the latest lazygit binary from GitHub and put it in the user's private bin directory
lazygit_version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
lazygit_tar=lazygit.tar.gz
curl -Lo $lazygit_tar "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
tar xf $lazygit_tar lazygit
rm $lazygit_tar
mv lazygit $USER_BIN_DIR/lazygit
