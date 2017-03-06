#!/bin/bash

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install zplug
git clone https://github.com/b4b4r07/zplug ~/.zplug

# link force dotfiles
ln -f .vimrc ~/.vimrc
ln -f .zshrc ~/.zshrc
ln -f .gitconfig ~/.gitconfig

vim +PluginInstall +qall

sudo chsh -s $(which zsh)
