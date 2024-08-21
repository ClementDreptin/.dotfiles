#!/bin/bash

set -e

# Download install script and run it with the following options:
# --no-modify-path  => Don't automatically append cargo environment by modifying .zshrc because it's already done
# -y                => Disable confirmation prompt
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
