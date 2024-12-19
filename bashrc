#!/bin/bash

# -------------------- Initial config (DO NOT TOUCH) --------------------

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# -------------------- local utililty functions --------------------

_have() {
  type "$1" &>/dev/null;
}

_source_if() {
  [[ -r "$1" ]] && source "$1";
}

pathappend() {
  declare arg

  for arg in "$@"; do
    test -d "$arg" || continue

    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="${PATH:+"$PATH:"}$arg"
  done
} && export -f pathappend

pathprepend() {
  for arg in "$@"; do
    test -d "$arg" || continue

    PATH=${PATH//:"$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="$arg${PATH:+":${PATH}"}"
  done
} && export -f pathprepend

# -------------------- Prompt --------------------

_dir_chomp () {
  local p=${1/#$HOME/\~} b s
  s=${#p}

  while [[ $p != "${p//\/}" ]]&&(($s>$2))
  do
    p=${p#/}
    [[ $p =~ \.?. ]]
    b=$b/${BASH_REMATCH[0]}
    p=${p#*/}
    ((s=${#b}+${#p}))
  done

  echo ${b/\/~/\~}${b+/}$p
}

export PS1='\[\e[92m\]\u\[\e[0m\] at \[\e[92m\]\h\[\e[0m\] in $(_dir_chomp "$(pwd)" 20) $ '

# -------------------- Bash Shell Options --------------------

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# -------------------- Pager --------------------

if [[ -x /usr/bin/lesspipe ]]; then
  export LESSOPEN="| /usr/bin/lesspipe %s"
  export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# -------------------- History --------------------

shopt -s histappend

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=1000

# -------------------- Completion --------------------

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# -------------------- VIM --------------------

export MYVIMRC='~/.vimrc'

# -------------------- NVM --------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -------------------- Java --------------------

export JAVA_HOME=/usr/bin/jvm/jdk-21-oracle-x64/
export PATH=$PATH:$JAVA_HOME/bin

# -------------------- Custom scripts --------------------

export PATH=$PATH:$HOME/dot/scripts
