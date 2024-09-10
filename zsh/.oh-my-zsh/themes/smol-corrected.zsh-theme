# vim:ft=zsh ts=2 sw=2 sts=2

#  @ smol
# ~~~~~~~~~~
# A minimalist theme for ZSH
#
# To use this, either install Nerd Fonts (nerdfonts.com).

FG_DIM=$'%{\e[38;5;8m%}'
FG_RED=$'%{\e[38;5;9m%}'
FG_NORMAL=$'%{\e[38;5;245m%}'

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
    print "${FG_DIM} %{$fg[$status_color]%} $(prompt_vi_git_info)%f%k"
  fi
}

prompt_vi_show_machine_name() {
  if [[ -n $SSH_CLIENT || -n $SSH_TTY || -n $SSH_CONNECTION ]]; then
    str=" %m %f%k"
    if git rev-parse --git-dir > /dev/null 2>&1; then
      print "${FG_DIM}| %F{yellow}$str"
    else
      print "${FG_DIM}| %F{yellow}$str"
    fi
  fi
}

CURRENT_LOCATION="${FG_DIM} @${FG_NORMAL} %1~%{$reset_color%} "
PROMPT="%(?,$FG_NORMAL,$FG_RED) %(?,λ,!) %{$reset_color%}${FG_DIM}| %{$reset_color%}%F{white}"
RPS1='$(prompt_vi_git_status)$CURRENT_LOCATION$(prompt_vi_show_machine_name)%k%f'
