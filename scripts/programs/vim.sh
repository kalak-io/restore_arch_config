#! /usr/bin/env bash

echo "Configuring vim"
mkdir -p $HOME/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
