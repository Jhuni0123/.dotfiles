### Alias
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vi="vim"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias sudo="sudo -H"
alias venv="echo \$VIRTUAL_ENV"
alias ls="ls -G"
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"

export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export TERM=xterm-256color

# locale to en_US
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

### PATH config ###
export PATH="/Users/jhuni/.local/bin:/Users/jhuni/Library/Python/2.7/bin:/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/lib/python2.7/site-packages/PySide:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

##oh-my-zsh##
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
#source ~/.oh-my-zsh/templates/zshrc.zsh-template

### Zplugin ###
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-completions
zplugin light simnalamburt/shellder
zplugin light simnalamburt/cgitc

# opam coq
export OPAMROOT=~/opam-coq.8.8.1
eval `opam config env`

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ctags
alias ctags="/usr/local/bin/ctags"
alias python_ctags="ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags . $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# direnv
eval "$(direnv hook zsh)"
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export PS1='$(show_virtual_env)'$PS1

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"


### Completions ###
# homebrew's completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# aws completions
source "$HOME/.local/bin/aws_zsh_completer.sh"


source "$HOME/.zshrc_private"
