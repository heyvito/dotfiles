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
ZSH_THEME="smol"
COMPLETION_WAITING_DOTS="true"

plugins=(git macos sublime colored-man-pages goenv)

source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/.go
export GO111MODULE=on
export ZLE_RPROMPT_INDENT=0
export CLICOLOR=1

if [[ "$(uname)" == "Darwin" ]]; then
  ruby_version="3.1.2"
  brew_prefix="/usr/local"
  brew_exec="${brew_prefix}/Homebrew/bin/brew"
  if [[ "$(uname -m)" == "arm64" ]]; then
    brew_prefix="/opt/homebrew"
    brew_exec="${brew_prefix}/bin/brew"
  fi

  if [[ -x "$brew_exec" ]]; then
    eval "$("$brew_exec" shellenv)"
    ruby_path="${brew_prefix}/opt/ruby/bin"
    gems_path="${brew_prefix}/lib/ruby/gems/$ruby_version/bin"
    export PATH="${ruby_path}:${gems_path}:$PATH"
  fi
  unset ruby_version brew_prefix brew_exec ruby_path gems_path
fi

export PATH=$HOME/.bin:$HOME/.bin.priv:$PATH:$GOPATH/bin:$HOME/.cargo/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.envs ] && source ~/.envs

alias please='sudo'

unalias gr  # created by 'git' plugin. Originally aliases to 'git remote'.
unalias grm # created by 'git' plugin. Originally aliases to 'git rm'.
unalias gra # created by 'git' plugin. Originally aliases to 'git remote add'.

dev() { cd ~/Developer/$1; }
compctl -W ~/Developer/ -/ dev

if [ -d $HOME/.config/zshrc.d ]; then
    for file in $HOME/.config/zshrc.d/*.zsh; do
        source "$file"
    done
fi
