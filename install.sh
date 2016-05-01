#!/bin/bash

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#install vim plugins
echo copy vimrc...
cp .vimrc $HOME/.vimrc
echo copy vim colorscheme...
cp -r colors $HOME/.vim/
echo install vim plugins...
vim +PluginInstall +qall

#install gitconfig
cp .gitconfig $HOME/.gitconfig
#install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#install zplug
git clone https://github.com/b4b4r07/zplug ~/.zplug

#install zsh plugins
cp .zshrc $HOME/.zshrc
chsh -s $(which zsh)
