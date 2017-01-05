#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

git clone https://github.com/b4b4r07/zplug ~/.zplug

ln .vimrc ~/.vimrc
ln .zshrc ~/.zshrc
ln .gitconfig ~/.gitconfig

vim +PluginInstall +qall

sudo chsh -s $(which zsh)
