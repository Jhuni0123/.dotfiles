alias dotfiles="vim ~/.dotfiles"
alias vi="vim"
alias mv="mv -i"
alias cp="cp -i"
alias sudo="sudo -H"
alias venv="echo \$VIRTUAL_ENV"

if [[ $OS == "macos" && $commands[gls] ]]; then
    alias ls="gls --color"
else
    alias ls="ls -G --color"
fi
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"

alias k=kubectl
alias tf=terraform
