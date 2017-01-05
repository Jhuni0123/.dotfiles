##oh-my-zsh##
export ZSH=$HOME/.oh-my-zsh

plugins=(git osx brew zsh-completions)

source $ZSH/oh-my-zsh.sh


##zplug##
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", use:zsh-syntax-highlighting.zsh
zplug "simnalamburt/shellder", as:theme

if ! zplug check; then; zplug install; fi
zplug load


##alias##
alias gitconfig="vim ~/.gitconfig"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
