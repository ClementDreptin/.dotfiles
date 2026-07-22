#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin
USER_CFG_DIR=$HOME/.config
USER_FONT_DIR=$HOME/.local/share/fonts

if [ ! -d $USER_BIN_DIR ]; then
  echo "User bin directory ($USER_BIN_DIR) not found, creating..."
  mkdir -p $USER_BIN_DIR
fi

if [ ! -d $USER_CFG_DIR ]; then
  echo "User config directory ($USER_CFG_DIR) not found, creating..."
  mkdir -p $USER_CFG_DIR
fi

if [ ! -d $USER_FONT_DIR ]; then
  echo "User font directory ($USER_FONT_DIR) not found, creating..."
  mkdir -p $USER_FONT_DIR
fi
