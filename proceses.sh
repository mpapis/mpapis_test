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
  existing=()
  for id in ${processes[@]}
  do
    if ps -p $id >/dev/null
    then existing+=( $id )
    fi
  done
  processes=( ${existing[@]} )
  (( ${#processes[@]} >= max )) || return $?
}

wait_if_max()
{
  processes+=( $1 )
  while filter_existing
  do sleep 1
  done
}

in_processes()
{
  typeset id name max=$1
  typeset -a processes existing
  processes=()
  for name in a b c d #e f g h i j k l m n
  do
    slow_function $name &
    wait_if_max $!
  done
  wait ${processes[@]}
}

in_processes 2
