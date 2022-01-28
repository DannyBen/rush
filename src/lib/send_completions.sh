## [@bashly-upgrade completions send_completions]
send_completions() {
  echo $'#!/usr/bin/env bash'
  echo $''
  echo $'# This bash completions script was generated by'
  echo $'# completely (https://github.com/dannyben/completely)'
  echo $'# Modifying it manually is not recommended'
  echo $'_rush_completions() {'
  echo $'  local cur=${COMP_WORDS[COMP_CWORD]}'
  echo $'  local comp_line="${COMP_WORDS[@]:1}"'
  echo $''
  echo $'  case "$comp_line" in'
  echo $'    \'completions\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'default\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'remove\'*) COMPREPLY=($(compgen -W "--help --purge -h -p" -- "$cur")) ;;'
  echo $'    \'config\'*) COMPREPLY=($(compgen -W "--edit --help -e -h" -- "$cur")) ;;'
  echo $'    \'snatch\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'search\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'clone\'*) COMPREPLY=($(compgen -A directory -W "--default --help --ignore --name --shallow --ssh -d -h -i -n -s -w" -- "$cur")) ;;'
  echo $'    \'pull\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'push\'*) COMPREPLY=($(compgen -W "--all --help --message -a -h -m" -- "$cur")) ;;'
  echo $'    \'undo\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --help -h" -- "$cur")) ;;'
  echo $'    \'copy\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --force --help -f -h" -- "$cur")) ;;'
  echo $'    \'info\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --help -h" -- "$cur")) ;;'
  echo $'    \'list\'*) COMPREPLY=($(compgen -W "--all --help --simple -a -h -s" -- "$cur")) ;;'
  echo $'    \'edit\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --help -h" -- "$cur")) ;;'
  echo $'    \'show\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --help -h" -- "$cur")) ;;'
  echo $'    \'add\'*) COMPREPLY=($(compgen -A directory -W "--help -h" -- "$cur")) ;;'
  echo $'    \'get\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --clone --help -c -h" -- "$cur")) ;;'
  echo $'    \'\'*) COMPREPLY=($(compgen -W "$(rush list -s -a) --help --version -h -v add clone completions config copy default edit get info list pull push remove search show snatch undo" -- "$cur")) ;;'
  echo $'  esac'
  echo $'}'
  echo $''
  echo $'complete -F _rush_completions rush'
}