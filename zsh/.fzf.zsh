
# In case fzf is installed...
if [[ -d /usr/local/opt/fzf ]]; then
    # Setup it
    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
      export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
    fi

    # [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
