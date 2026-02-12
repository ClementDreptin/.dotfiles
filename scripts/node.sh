#!/bin/bash

set -e

# Install NVM if needed
if [ ! -f "$HOME/.nvm/nvm.sh" ]; then
  echo "NVM is not installed, installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Instead of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Install the latest node version with NVM
echo "Installing node..."
nvm install --lts
