
# Custom Bash Prompt
export PS1=' \[\033[1;32m\]\W\[\033[0m\]\[\033[1;31m\]$(__git_ps1 " (%s)")\[\033[0m\] > '

jmp() {
  cd -P "$HOME/jmp/$1"
}

_jmp_completions() {
  local cur="''${COMP_WORDS[COMP_CWORD]}"
  local dirs=$(command ls -1 "$HOME/jmp" 2>/dev/null)
  COMPREPLY=( $(compgen -W "$dirs" -- "$cur") )
}

complete -F _jmp_completions jmp

