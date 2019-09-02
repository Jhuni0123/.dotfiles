# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# homebrew's completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

##oh-my-zsh##
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#zplug#
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "simnalamburt/shellder", as:theme
zplug "zsh-users/zsh-completions", depth:1
zplug "simnalamburt/cgitc"
zplug "lukechilds/zsh-nvm"

if ! zplug check; then; zplug install; fi
zplug load

##alias##
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vi="vim"
alias mv="mv -i"
alias cp="cp -i"
alias sudo="sudo -H"
alias venv="echo \$VIRTUAL_ENV"

export TERM=xterm-256color

# node
export PATH="/Users/jhuni/.local/bin:/Users/jhuni/Library/Python/2.7/bin:/usr/local/opt/node@8/bin:$PATH"

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
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pipx binaries
export PATH="$HOME/.local/bin:$PATH"

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# virtualenvwrapper
#export WORKON_HOME=$HOME/.venvs
#source /usr/local/bin/virtualenvwrapper.sh

# pyenv-virtualenvwrapper
pyenv virtualenvwrapper_lazy

# path
export PATH="/usr/local/sbin:$PATH"

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# gnubin
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"
