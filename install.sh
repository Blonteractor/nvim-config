#!/bin/bash

if ! command -v nvim /dev/null
then
    echo "neovim could not be found, please install the latest version"
    exit 1
fi

echo "Deleting old cache"
rm -rf ~/.local/share/nvim

echo "Backing up old config to ~/.config/nvim.bkp"
mv ~/.config/nvim/ ~/.config/nvim.bkp 

echo "Installing NvChad"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

echo "Installing custom config"
rm -rf ~/.config/nvim/lua/custom
git clone https://github.com/blonteractor/nvim-config ~/.config/nvim/lua/custom/

nvim
