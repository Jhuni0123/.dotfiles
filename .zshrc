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
alias lscolor="vim ~/.oh-my-zsh/lib/theme-and-appearance.zsh"
alias aws="ssh -i '~/.ssh/MyAWSKey.pem' ubuntu@ec2-52-79-107-110.ap-northeast-2.compute.amazonaws.com"
alias martini="ssh whdgnsdl887@martini.snu.ac.kr"
