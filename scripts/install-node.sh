#!/bin/bash

# Install volta if needed
if [ ! -f "$HOME/.volta/bin/volta" ]; then
  echo "Volta is not installed, installing..."
  curl https://get.volta.sh | bash -s -- --skip-setup
fi

# Install the latest node version with volta
echo "Installing node..."
volta install node
