#!/bin/bash

GIT_DIR="$(git rev-parse --show-toplevel)"
ZSH_HOME=$HOME/.oh-my-zsh
ZSH_CUSTOM=$ZSH_HOME/custom

# Install Zsh if needed
zsh --version > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
    echo "Zsh is not installed, installing..."
    sudo apt install zsh
fi

# Install oh-my-zsh if needed
if [ ! -d $ZSH_HOME ]; then
    zshrc_src=$GIT_DIR/terminal/.zshrc
    zshrc_dest=$HOME/.zshrc
    echo "Installing .zshrc..."
    echo "$zshrc_src --> $zshrc_dest"
    ln -s $zshrc_src $zshrc_dest

    # Install oh-my-zsh without overwriting our .zshrc
    export KEEP_ZSHRC=yes
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install our custom catppuccin theme if needed
catppuccin_theme_src=$GIT_DIR/terminal/catppuccin.zsh-theme
catppuccin_theme_dest=$ZSH_CUSTOM/themes/catppuccin.zsh-theme
if [ ! -f $catppuccin_theme_dest ]; then
    echo "Installing catppuccin theme..."
    echo "$catppuccin_theme_src --> $catppuccin_theme_dest"
    ln -s $catppuccin_theme_src $catppuccin_theme_dest
fi

# Install plugins if needed
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in ${plugins[@]}; do
    plugin_path=$ZSH_CUSTOM/plugins/$plugin
    if [ ! -d $plugin_path ]; then
        echo "Installing $plugin..."
        git clone https://github.com/zsh-users/$plugin $plugin_path
    fi
done

# Run zsh
zsh
