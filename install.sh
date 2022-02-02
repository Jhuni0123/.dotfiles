#!/bin/bash

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# link force dotfiles
ln -f .gitconfig ~/.gitconfig

echo "export DOTFILES_HOME=$(pwd)
source $(pwd)/zshrc/basic.zsh
" > ~/.zshrc

echo "source $(pwd)/vimrc/basic.vim" > ~/.vimrc
vim +PlugInstall +qall

# sudo chsh -s $(which zsh)
