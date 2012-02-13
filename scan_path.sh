#!/usr/bin/env bash

scan_path_dirname()
{
  typeset target home current _file
  target=$1
  home="$(dirname $HOME)"

  current="$PWD"
  while [[ "$current" != "/" && "$current" != "$home" ]]
  do
    _file="$current/.env"
    if [[ -e "$_file" ]]
    then source "${_file}"
    fi
    current="$(dirname "${current}")"
  done
}

scan_path_cd()
{
  typeset target home
  target=$1
  home="$(dirname $HOME)"

  (
    while [[ "$PWD" != "/" && "$PWD" != "$home" ]]
    do
      _file="$PWD/.env"
      if [[ -e "$_file" ]]
      then source "${_file}"
      fi
      builtin cd ..
    done
  )
}

echo ""
echo dirname
time scan_path_dirname ${1:-.env}

echo ""
echo cd
time scan_path_cd ${1:-.env}
