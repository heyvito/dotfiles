export ZSH_COMPDUMP="/Users/$USER/.zcompdump"
autoload -Uz compinit

ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="victorgama"
ZSH_THEME="vito"
COMPLETION_WAITING_DOTS="true"

plugins=(git sublime osx httpie brew docker colored-man-pages docker-compose golang)

source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/Hacking/go
export GO111MODULE=on
export WORKON_HOME=$HOME/.virtualenvs
export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:$PATH:$HOME/.rvm/bin:$NODEBIN:/usr/local/share/npm/bin:$GOPATH/bin:~/Library/Python/3.6/bin:$HOME/.cargo/bin:/usr/local/lib/ruby/gems/2.6.0/bin
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
export PYTHONDONTWRITEBYTECODE=1
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.envs ] && source ~/.envs

function docker-compose {
  wd=$(pwd)
  if [[ "$wd" =~ ^/Users/victorgama/Hacking.* ]]; then
    wd=$(pwd | sed "s/\/Users\/victorgama\/Hacking\///" | sed "s/\//-/g")
    export COMPOSE_PROJECT_NAME=$wd
  fi
  /usr/local/bin/docker-compose $@
}

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

unalias gr # created by 'git' plugin. Originally aliases to 'git remote'.
unalias grm # created by 'git' plugin. Originally aliases to 'git rm'.

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
grm() { _gb && _gtgh "milestones" } # Go to Repository Milestones
grr() { _gb && _gtgh "releases" }
grnp() {
    BRANCH_NAME=$(git symbolic-ref HEAD | sed 's/refs\/heads\///g')
    _gb && _gtgh "compare/$BRANCH_NAME?expand=1"
}

gogo() {
    if [[ "$1" == *"/"* ]]; then
        cd $GOPATH/src/github.com/$1
    else
        cd $GOPATH/src/github.com/$DEFAULT_USER/$1
    fi
}
compctl -W $GOPATH/src/github.com/ -/ gogo

hack() { cd ~/Hacking/$1; }
compctl -W ~/Hacking/ -/ hack

function tlvd() {
    pbpaste \
    | awk '{printf "%s ", $0}' \
    | sed -E 's/(0x[^ ]+:|0x|[[:blank:]])//g' \
    | tlvp
}


function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
  done
}
