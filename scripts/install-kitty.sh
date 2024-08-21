#!/bin/bash

set -e

USER_BIN_DIR=$HOME/.local/bin
KITTY_DIR=$HOME/.local/kitty.app
DESKTOP_INTG_DIR=$HOME/.local/share/applications

echo "Installing kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Creating symlinks for kitty and kitten in ~/.local/bin..."
ln -sf $KITTY_DIR/bin/kitty $USER_BIN_DIR/kitty
ln -sf $KITTY_DIR/bin/kitten $USER_BIN_DIR/kitten

echo "Adding desktop icons..."
cp $KITTY_DIR/share/applications/kitty.desktop $DESKTOP_INTG_DIR/
sed -i "s|Icon=kitty|Icon=$KITTY_DIR/share/icons/hicolor/256x256/apps/kitty.png|g" $DESKTOP_INTG_DIR/kitty.desktop
sed -i "s|Exec=kitty|Exec=$KITTY_DIR/bin/kitty|g" $DESKTOP_INTG_DIR/kitty.desktop

echo "Setting kitty as default terminal..."
sudo update-alternatives --set x-terminal-emulator $(which kitty)
