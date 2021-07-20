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
ZSH_THEME="theto"
COMPLETION_WAITING_DOTS="true"

plugins=(git sublime osx docker colored-man-pages docker-compose golang)

source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/Developer/go
export GO111MODULE=on
export WORKON_HOME=$HOME/.virtualenvs
export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:/usr/local/opt/ruby/bin:/usr/local/bin:$PATH:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.bin
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
export PYTHONDONTWRITEBYTECODE=1
export CLICOLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.envs ] && source ~/.envs

alias curlimg='xargs curl | imgcat'
alias dcr='docker-compose run --rm $@'
alias dce='docker-compose exec'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcp='docker-compose pull $@'
alias dsa='docker ps -q | xargs docker stop'
alias dclf='docker-compose logs -f'
alias pip=/usr/local/bin/pip3
alias ss='slack-status'
alias please='sudo'

unalias gr # created by 'git' plugin. Originally aliases to 'git remote'.
unalias grm # created by 'git' plugin. Originally aliases to 'git rm'.
unalias gra # created by 'git' plugin. Originally aliases to 'git remote add'.

docker-compose() {
  wd=$(pwd)
  cu=$(whoami)
  if [[ "$wd" =~ ^/Users/$cu/Developer.* ]]; then
    wd=$(pwd | sed "s/\/Users\/$cu\/Developer\///" | sed "s/\//-/g")
    export COMPOSE_PROJECT_NAME=$wd
  fi
  /usr/local/bin/docker-compose $@
}

_gb() {
  local _gb_base=$(git remote get-url origin \
                      | sed -E 's/.*(@|\/\/)(.*)\.git/\2/' \
                      | sed 's/:/\//g');
  if [[ "$_gb_base" == "" ]]; then
    return 1;
  fi
  _gh_url="https://$_gb_base";
}
_gtgh() { open "$_gh_url/$1"; unset _gh_url; }

gr() { _gb && _gtgh } # Go to Repository
gri() { _gb && _gtgh "issues" } # Go to Repository Issues
grin() { _gb && _gtgh "issues/new/choose" } # Go to Repository Issues for
                                            # creating a New one
gra() { _gb && _gtgh "actions" } # Go to Repository Actions
grm() { _gb && _gtgh "milestones" } # Go to Repository Milestones
grr() { _gb && _gtgh "releases" } # Go to Repository Releases
grnp() {
  BRANCH_NAME=$(git symbolic-ref HEAD | sed 's/refs\/heads\///g')
  _gb && _gtgh "compare/$BRANCH_NAME?expand=1"
}

dev() { cd ~/Developer/$1; }
compctl -W ~/Developer/ -/ dev

hack() { echo "\ahack is now dev"; cd ~/Developer/$1; }
compctl -W ~/Developer/ -/ hack

tlvd() {
  pbpaste \
    | awk '{printf "%s ", $0}' \
    | perl -pe 's/0x([0-9a-fA-F])(?=[^0-9a-fA-F])/0x0$1/g' \
    | sed -E 's/(0x[^ ]+:|0x|[[:blank:]])//g' \
    | tlvp
}

cljdoc() {
  term="$1"
  if [[ "$term" == "/"* ]]; then
    open "https://clojuredocs.org/search?q=${term:1}"
  elif [[ "$term" == "c."* ]]; then
    open "https://clojuredocs.org/clojure.core${term:1}"
  elif [[ "$term" == *"/"* ]]; then
    open "https://clojuredocs.org/$term"
  else
    open "https://clojuredocs.org/clojure.core/$term"
  fi
}

pbjson() {
  pbpaste > /tmp/pbjson
  cat /tmp/pbjson | jq | pbcopy
  rm /tmp/pbjson
}

pbxml() {
  pbpaste > /tmp/pbxml
  xmllint --format /tmp/pbxml | pbcopy
  rm /tmp/pbxml
}

pbase64() {
  pbpaste > /tmp/pbase64
  cat /tmp/pbase64 | base64 | pbcopy
  rm /tmp/pbase64
}

if [ -d $HOME/.config/zshrc.d ]; then
    for file in $HOME/.config/zshrc.d/*.zsh; do
        source "$file"
    done
fi
