#!/bin/bash

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# link force dotfiles
ln -f .vimrc ~/.vimrc
ln -f .zshrc ~/.zshrc
ln -f .gitconfig ~/.gitconfig
ln -s .zsh ~/.zsh

vim +PlugInstall +qall

# sudo chsh -s $(which zsh)
