#!/bin/sh

echo "Connect Git config..."
git config --global include.path "${PWD}/gitconfig_global"

echo "Connect zsh config..."
echo "export DOTFILES_HOME=${PWD}
source ${PWD}/zshrc/basic.zsh
" > ~/.zshrc

echo ''
echo "Change your default shell to zsh"
echo '  $ chsh -s $(which zsh)'
echo '  or'
echo "  $ echo 'exec zsh' >> ~/.bash_profile"
echo ''

echo "Connect vim config..."
echo "source ${PWD}/vimrc/basic.vim" > ~/.vimrc
