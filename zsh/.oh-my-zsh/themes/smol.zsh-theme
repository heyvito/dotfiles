# vim:ft=zsh ts=2 sw=2 sts=2

#  @ smol
# ~~~~~~~~~~
# A minimalist theme for ZSH
#
# To use this, either install Nerd Fonts (nerdfonts.com).

FG_R=$'%{\e[38;5;9m%}'
IN_A=$'%{\e[0m%}%{\e[38;5;237m%}'

FG_B=$'%{\e[38;5;252m%}'

FG_C=$'%{\e[38;5;245m%}'

prompt_vi_git_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) \
    || ref=$(command git rev-parse --short HEAD 2> /dev/null) \
    || return 0

  printf "${ref#refs/heads/}"
}

prompt_vi_git_status() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if test -z "$(git status --porcelain --ignore-submodules)"; then
      status_color="cyan"
    else
      status_color="red"
    fi
    print "${IN_A} $FG_B%{$fg[$status_color]%} $(prompt_vi_git_info)%f%k"
  fi
}

prompt_vi_show_machine_name() {
  if [[ -n $SSH_CLIENT || -n $SSH_TTY || -n $SSH_CONNECTION ]]; then
    local prev_color;
    local default_color;
    str=" %m  %f%k"
    if git rev-parse --git-dir > /dev/null 2>&1; then
      print "${IN_A}| %F{yellow}$str"
    else
      print "${IN_A}| %F{yellow}$str"
    fi
  fi
}

CURRENT_LOCATION="${IN_A} @${FG_C} %1~%{$reset_color%} "
PROMPT="%(?,$FG_C,$FG_R) %(?,λ,!) %{$reset_color%}${IN_A}| %{$reset_color%}%F{white}"
RPS1='$(prompt_vi_git_status)$CURRENT_LOCATION$(prompt_vi_show_machine_name)%k%f'
