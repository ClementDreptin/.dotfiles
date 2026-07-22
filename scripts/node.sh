#!/bin/bash

set -e

if [ ! -f "$HOME/.nvm/nvm.sh" ]; then
  echo "NVM is not installed, installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Instead of restarting the shell
\. "$HOME/.nvm/nvm.sh"

echo "Installing node..."
nvm install --lts

echo "Installing pnpm..."
curl -fsSL https://get.pnpm.io/install.sh | sh -
