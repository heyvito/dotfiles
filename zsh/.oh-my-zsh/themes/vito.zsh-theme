# Vito
# Based on Geometry and TerminalParty
# geometry: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/geometry.zsh-theme
# avit:     https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/terminalparty.zsh-theme

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

prompt_vi_commit_time() {
  if [[ $(git log -1 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit / 3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
      color="%F{magenta}"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
      color="%F{white}"
    else
      commit_age="${minutes}m"
      color="%F{green}"
    fi

    echo "$color$commit_age"
  fi
}

prompt_vi_git_status() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if test -z "$(git status --porcelain --ignore-submodules)"; then
      status_color="%F{242}"
    else
      status_color="%F{005}"
    fi
    echo "$status_color($(git_prompt_info):$(prompt_vi_commit_time)$status_color)"
  else
    echo "%F{white}"
  fi
}

prompt_vi_show_machine_name() {
  if [ -v SSH_CLIENT ] ; then
    echo " %F{blue}%m%f"
  fi
}


PROMPT="%(?,%F{242},%F{red}) ▲ %F{white}%f"
RPS1='%2~ $(prompt_vi_git_status)%f$(prompt_vi_show_machine_name)'

