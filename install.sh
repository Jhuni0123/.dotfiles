#!/bin/bash

git config --global include.path "${PWD}/gitconfig_global"

echo "export DOTFILES_HOME=${PWD}
source ${PWD}/zshrc/basic.zsh
" > ~/.zshrc

echo "source ${PWD}/vimrc/basic.vim" > ~/.vimrc
vim +PlugInstall +qall

# sudo chsh -s $(which zsh)
