##oh-my-zsh##
export ZSH=$HOME/.oh-my-zsh

plugins=(git osx brew zsh-syntax-highlighting zsh-completions)

source $ZSH/oh-my-zsh.sh


##zplug##
source ~/.zplug/zplug

#zplug "zsh-users/zsh-syntax-highlighting", of:zsh-syntax-highlighting.zsh
zplug "simnalamburt/shellder"

if ! zplug check; then; zplug install; fi
zplug load


##alias##
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
