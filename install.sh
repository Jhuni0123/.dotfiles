#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln .vimrc ~/.vimrc
ln .zshrc ~/.zshrc
ln .gitconfig ~/.gitconfig

vim +PluginInstall +qall

git clone https://github.com/tomasr/molokai.git ./
mkdir -p ~/.vim/colors
cp -r ./molokai/colors/molokai.vim ~/.vim/colors/

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

git clone https://github.com/b4b4r07/zplug ~/.zplug

sudo chsh -s $(which zsh)
