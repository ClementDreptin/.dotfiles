#!/bin/bash

set -e

GIT_DIR="$(git rev-parse --show-toplevel)"
GHOSTTY_CONF_DIR=$HOME/.config/ghostty
FONT_NAME=JetBrainsMono
FONT_FILE_NAME=$FONT_NAME.zip
USER_FONT_DIR=$HOME/.local/share/fonts

# Script taken here:
# https://github.com/mkasberg/ghostty-ubuntu#installupdate
echo "Installing Ghostty..."
source /etc/os-release
GHOSTTY_DEB_URL=$(
   curl -s https://api.github.com/repos/mkasberg/ghostty-ubuntu/releases/latest | \
   grep -oP "https://github.com/mkasberg/ghostty-ubuntu/releases/download/[^\s/]+/ghostty_[^\s/_]+_amd64_${VERSION_ID}.deb"
)
GHOSTTY_DEB_FILE=/tmp/$(basename $GHOSTTY_DEB_URL)
curl -L $GHOSTTY_DEB_URL -o $GHOSTTY_DEB_FILE
sudo dpkg -i $GHOSTTY_DEB_FILE
rm $GHOSTTY_DEB_FILE

# The .deb file already adds an alternative for x-terminal-emulator so no need to add one manually
echo "Setting Ghostty as the default terminal..."
sudo update-alternatives --set x-terminal-emulator $(which ghostty)

echo "Installing Ghostty configuration..."
ln -sf $GIT_DIR/terminal/config $GHOSTTY_CONF_DIR/config

echo "Installing font..."
curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_FILE_NAME -o /tmp/$FONT_FILE_NAME
unzip /tmp/$FONT_FILE_NAME -d $USER_FONT_DIR/$FONT_NAME
rm /tmp/$FONT_FILE_NAME
fc-cache -f -v
