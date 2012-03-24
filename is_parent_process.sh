#!/usr/bin/env bash

is_parent_of()
{
  typeset name pid ppid pname
  name=$1
  pid=$2
  while [[ -n "$pid" && "$pid" != "0" ]]
  do
    read ppid pname < <(ps -p $pid -o ppid= -o comm=)
    if [[ -n "$ppid" && -n "$pname" ]]
    then
      if [[ "$pname" == "$name" ]]
      then
        echo $pid
        return 0
      else
        pid=$ppid
      fi
    fi
  done
  return 1
}

if [[ -n "$1" ]] && ppid=$( is_parent_of $1 $$ )
then
  echo "$1(pid=$ppid) is parent of $$"
else
  echo "$1 is not parent of $$"
fi
