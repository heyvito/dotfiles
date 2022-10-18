__goenv_join_by() { local IFS="$1"; shift; echo "$*"; }

__goenv_load_file() {
  file="$1";
  privates=($(grep -E 'private ([^\n]+)' .goenv | sed -E 's/private ([^\n]+)/\1/'));
  export GOPRIVATE="$(__goenv_join_by , "${privates[@]}")";
}

__goenv_handler() {
  localfile="$PWD/.goenv";
  if [[ -f "$localfile" ]]; then
    export __goenv_prev_goenv="$localfile";
    export __goenv_prev_goprivate="-$GOPRIVATE";
    __goenv_load_file "$localfile"
  else
    if [[ -n "$__goenv_prev_goprivate" ]]; then
      export GOPRIVATE="${__goenv_prev_goprivate:1}";
      unset __goenv_prev_goprivate;
    fi
  fi
}

chpwd_functions+=(__goenv_handler);
