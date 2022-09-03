#!/bin/sh

# git config
echo "Connect Git config..."
git config --global include.path "${PWD}/gitconfig_global"

# zsh
echo "Connect zsh config..."
echo "export DOTFILES_HOME=${PWD}
source ${PWD}/zshrc/basic.zsh
" >> ~/.zshrc

echo ''
echo "Change your default shell to zsh"
echo '  $ chsh -s $(which zsh)'
echo '  or'
echo "  $ echo 'exec zsh' >> ~/.bash_profile"
echo ''

# vim
echo "Connect vim config..."
echo "source ${PWD}/vimrc/basic.vim" >> ~/.vimrc

# tmux
echo "Connect tmux config..."
echo "source-file ${PWD}/tmux.conf" >> ~/.tmux.conf
echo "  Press '<C-b> I' to install plugins."

# direnv
echo "Connect direnv config..."
echo "source ${PWD}/direnvrc" >> ~/.direnvrc
