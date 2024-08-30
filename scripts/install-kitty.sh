#!/bin/bash

set -e

GIT_DIR="$(git rev-parse --show-toplevel)"
USER_BIN_DIR=$HOME/.local/bin
KITTY_DIR=$HOME/.local/kitty.app
KITTY_CONF_DIR=$HOME/.config/kitty
DESKTOP_INTG_DIR=$HOME/.local/share/applications
FONT_NAME=JetBrainsMono
FONT_FILE_NAME=$FONT_NAME.zip
FONT_DIR=$HOME/.local/share/fonts

# Create the user's private bin directory if needed
if [ ! -d $USER_BIN_DIR ]; then
  echo "Private bin directory ($USER_BIN_DIR) not found, creating..."
  mkdir -p $USER_BIN_DIR
fi

# Create the user's private font directory if needed
if [ ! -d $FONT_DIR ]; then
  echo "Local font directory ($FONT_DIR) not found, creating..."
  mkdir -p $FONT_DIR
fi

echo "Installing kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n

echo "Creating symlinks for kitty and kitten in ~/.local/bin..."
ln -sf $KITTY_DIR/bin/kitty $USER_BIN_DIR/kitty
ln -sf $KITTY_DIR/bin/kitten $USER_BIN_DIR/kitten

echo "Adding desktop icons..."
cp $KITTY_DIR/share/applications/kitty.desktop $DESKTOP_INTG_DIR/
sed -i "s|Icon=kitty|Icon=$KITTY_DIR/share/icons/hicolor/256x256/apps/kitty.png|g" $DESKTOP_INTG_DIR/kitty.desktop
sed -i "s|Exec=kitty|Exec=$KITTY_DIR/bin/kitty|g" $DESKTOP_INTG_DIR/kitty.desktop

echo "Setting kitty as the default terminal..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 40
sudo update-alternatives --set x-terminal-emulator $(which kitty)

echo "Installing kitty configuration..."
ln -sf $GIT_DIR/terminal/kitty.conf $KITTY_CONF_DIR/kitty.conf

echo "Setting kitty theme..."
kitten themes Catppuccin-Mocha

echo "Installing font..."
curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_FILE_NAME -o /tmp/$FONT_FILE_NAME
unzip /tmp/$FONT_FILE_NAME -d $FONT_DIR/$FONT_NAME
rm /tmp/$FONT_FILE_NAME
fc-cache -f -v
