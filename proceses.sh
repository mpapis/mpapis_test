#!/usr/bin/env bash

slow_function()
{
  typeset num=$(( (RANDOM % 10) + 1 ))
  echo entering:$1:$num
  sleep $num
  echo finishing:$1:$num
}

filter_existing()
{
  typeset id
  typeset -a existing
  existing=()
  for id in ${processes[@]}
  do
    if [[ -d /proc/$id ]]
    then existing+=( $id )
    fi
  done
  processes=( ${existing[@]} )
  (( ${#processes[@]} >= $1 )) || return $?
}

wait_if_max()
{
  processes+=( $2 )
  while filter_existing $1
  do sleep 1
  done
}

in_processes()
{
  typeset name
  typeset -a processes
  processes=()
  for name in a b c d #e f g h i j k l m n
  do
    slow_function $name &
    wait_if_max $1 $!
  done
  wait ${processes[@]}
}

in_processes 2
