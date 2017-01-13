##oh-my-zsh##
export ZSH=$HOME/.oh-my-zsh

plugins=(git osx brew zsh-completions)

source $ZSH/oh-my-zsh.sh


#zplug#
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "simnalamburt/shellder", as:theme

if ! zplug check; then; zplug install; fi
zplug load


##alias##
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vi="vim"
alias mv "mv -i"
alias cp "cp -i"
