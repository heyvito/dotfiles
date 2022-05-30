# vim:ft=zsh ts=2 sw=2 sts=2

#  ▲ Theto
# ~~~~~~~~~~
# A simplistic theme for ZSH
#
# To use this, either install Nerd Fonts (nerdfonts.com)
# or change box_suffix and box_prefix with symbols available
# in your font of choice.

BG_A=$'%{\e[48;5;237m%}'
FG_A=$'%{\e[38;5;252m%}'
FG_R=$'%{\e[38;5;9m%}'
IN_A=$'%{\e[0m%}%{\e[38;5;237m%}'

BG_B=$'%{\e[48;5;238m%}'
FG_B=$'%{\e[38;5;252m%}'
IN_B=$'%{\e[48;5;237m%}%{\e[38;5;238m%}'

BG_C=$'%{\e[48;5;239m%}'
FG_C=$'%{\e[38;5;252m%}'
IN_C=$'%{\e[48;5;238m%}%{\e[38;5;239m%}'

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
    print "${IN_B}$BG_B$FG_B %{$fg[$status_color]%}\uf419 %{$fg[white]%}$(prompt_vi_git_info)  %f%k"
  fi
}

prompt_vi_show_machine_name() {
  if [[ -n $SSH_CLIENT || -n $SSH_TTY || -n $SSH_CONNECTION ]]; then
    local prev_color;
    local default_color;
    str="  %m  %f%k"
    if git rev-parse --git-dir > /dev/null 2>&1; then
      print "${IN_C}${BG_C}${FG_C}$str"
    else
      print "${IN_B}${BG_B}${FG_B}$str"
    fi
  fi
}

CURRENT_LOCATION="${IN_A}${FG_A}${BG_A} %1~ %{$reset_color%}"
PROMPT="$BG_A%(?,$FG_A,$FG_R) %(?,λ,!) %{$reset_color%}${IN_A} %{$reset_color%}%F{white}"
RPS1='$CURRENT_LOCATION$(prompt_vi_git_status)$(prompt_vi_show_machine_name)%k%f'
