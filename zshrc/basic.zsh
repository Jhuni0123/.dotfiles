# unmap <C-s>
stty stop undef

export GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$PATH"

if [ -d ~/.local/bin ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d ~/.cargo/bin ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d ~/.npm-global/bin ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d ~/.poetry ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -d ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

if [ -d ~/.yarn/bin ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

if [[ $commands[ruby] && $commands[gem] ]]; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if [ $commands[nvim] ]; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

#
# zinit
#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -f ${ZINIT_HOME}/zinit.zsh ]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

if [ -f ${ZINIT_HOME}/zinit.zsh ]; then
    source ${ZINIT_HOME}/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    zinit ice depth=1
    zinit light romkatv/powerlevel10k

    zinit wait lucid for \
            zdharma-continuum/fast-syntax-highlighting \
        atload'_zsh_autosuggest_start' \
            zsh-users/zsh-autosuggestions \
            pbzweihander/truck \
            simnalamburt/cgitc \
        pick".kubectl_aliases" \
            ahmetb/kubectl-aliases \
            voronkovich/gitignore.plugin.zsh \
        src"z.sh" \
            rupa/z \
            zsh-users/zsh-history-substring-search \
        atinit"export NVM_LAZY_LOAD=true" \
            lukechilds/zsh-nvm \
        from"gh-r" as"program" mv"direnv* -> direnv" atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src="zhook.zsh" \
            direnv/direnv
    zinit wait lucid as"completion" for \
        has"helm" id-as"helm-completion" atclone"helm completion zsh > _helm" pick"_helm" atpull"%atclone" run-atpull \
            zdharma-continuum/null \
        has"kubectl" id-as"kubectl-completion" atclone"kubectl completion zsh > _kubectl" atpull"%atclone" run-atpull \
            zdharma-continuum/null \
        has"pipx" id-as"pipx-completion" atclone"cat <(echo '#compdef pipx') <(register-python-argcomplete pipx) > _pipx" pick"_pipx" atpull"%atclone" run-atpull \
            zdharma-continuum/null \
        id-as'git-completion' \
            https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
    zinit wait lucid blockf atpull'zinit creinstall -q .' for \
        zsh-users/zsh-completions
fi

#
# Configs
#

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# keybinding
export KEYTIMEOUT=1
bindkey -e
#bindkey -M vicmd "^a" beginning-of-line
#bindkey -M vicmd "^e" end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;3D' backward-word

#
# Plugin Configs
#



# zsh-case-insensitive-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'

# zsh-substring-completion
setopt complete_in_word
setopt always_to_end
export WORDCHARS=''
zmodload -i zsh/complist

#zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#
# External programs
#

# sources
if [ -f ~/.opam/opam-init/init.zsh ]; then
    source ~/.opam/opam-init/init.zsh
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

if [ $commands[rbenv] ]; then
    eval "$(rbenv init -)"
fi

if [ $commands[pyenv] ]; then
    # eval "$(pyenv init -)"
fi

#
# Completions
#
fpath+=~/.zfunc
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

if [ $commands[terraform] ]; then
    complete -o nospace -C $(which terraform) terraform
fi

if [ $commands[aws] ]; then
    complete -C "$(which aws_completer)" aws
fi


#
# Etc
#

# fzf with tmux
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

if [ $commands[direnv] ]; then
    alias tmux='direnv exec / tmux'
    alias reload="direnv exec / $SHELL"
    direnv reload 2>/dev/null || true
fi

if [[ `uname` == "Darwin" ]]; then
    OS="macos"
fi

source ${DOTFILES_HOME}/zshrc/aliases.zsh
source ${DOTFILES_HOME}/zshrc/aws_profile.zsh
source ${DOTFILES_HOME}/zshrc/p10k.zsh
