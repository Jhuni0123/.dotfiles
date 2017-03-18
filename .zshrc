##oh-my-zsh##
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#zplug#
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "simnalamburt/shellder", as:theme
zplug "zsh-users/zsh-completions", depth:1
zplug "simnalamburt/cgitc"

if ! zplug check; then; zplug install; fi
zplug load

##alias##
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vi="vim"
alias mv="mv -i"
alias cp="cp -i"

export TERM=xterm-256color
