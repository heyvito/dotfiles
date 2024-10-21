# vim: set expandtab ts=2 sw=2 :

#    ,ggg,         ,gg
#   dP""Y8a       ,8P        I8
#   Yb, `88       d8'        I8
#    `"  88       88  gg  88888888
#        88       88  ""     I8
#        I8       8I  gg     I8      ,ggggg,
#        `8,     ,8'  88     I8     dP"  "Y8ggg
#         Y8,   ,8P   88    ,I8,   i8'    ,8I
#          Yb,_,dP  _,88,_ ,d88b, ,d8,   ,d8'
#           "Y8P"   8P""Y888P""Y88P"Y8888P"

export ZSH_COMPDUMP="/Users/$USER/.zcompdump"
export LC_ALL=en_US.UTF-8
autoload -Uz compinit

ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="heyvito"
ZSH_THEME="smol-corrected"
COMPLETION_WAITING_DOTS="true"

plugins=(git macos colored-man-pages goenv sublime)

source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/.go
export GO111MODULE=on
export ZLE_RPROMPT_INDENT=0
export CLICOLOR=1

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$HOME/.bin:$HOME/.bin.priv:/opt/homebrew/opt/ruby/bin:$PATH:$GOPATH/bin:$HOME/.cargo/bin

function autosource() {
  [ -f "$1" ] && source "$1";
}

autosource "~/.fzf.zsh"
autosource "~/.envs"
autosource "/opt/homebrew/opt/chruby/share/chruby/chruby.sh"
autosource "/opt/homebrew/opt/chruby/share/chruby/auto.sh"

alias please='sudo'

unalias gr  # created by 'git' plugin. Originally aliases to 'git remote'.
unalias grm # created by 'git' plugin. Originally aliases to 'git rm'.
unalias gra # created by 'git' plugin. Originally aliases to 'git remote add'.

dev() { cd ~/Developer/$1; }
compctl -W ~/Developer/ -/ dev
gac() { cd "$(pwd)-chart" }
rr() {
  local target_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? != 0 ]]; then
    echo "Fatal: Not in a git repository"
    return
  fi
  cd "$target_path"
}

eval "$(atuin init zsh --disable-up-arrow)"
command -v chruby 2>&1 >/dev/null && chruby 3.3.5
