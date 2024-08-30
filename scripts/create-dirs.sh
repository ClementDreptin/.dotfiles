#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin
USER_CFG_DIR=$HOME/.config
USER_FONT_DIR=$HOME/.local/share/fonts

# Create the user's private bin directory if needed
if [ ! -d $USER_BIN_DIR ]; then
  echo "Private bin directory ($USER_BIN_DIR) not found, creating..."
  mkdir -p $USER_BIN_DIR
fi

# Create the user's config directory if needed
if [ ! -d $USER_CFG_DIR ]; then
  mkdir -p $USER_CFG_DIR
fi

# Create the user's private font directory if needed
if [ ! -d $USER_FONT_DIR ]; then
  echo "Local font directory ($USER_FONT_DIR) not found, creating..."
  mkdir -p $USER_FONT_DIR
fi

