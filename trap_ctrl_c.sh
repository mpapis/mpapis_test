#!/bin/bash

control_c()
# run if user hits control-c
{
  echo -en "\n*** Ouch! Exiting ***\n"
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

# main() loop
fun()
{
  while true; do read x; done
}

cd()
{
  if builtin cd $@
  then
    fun
    return 0
  else
    return $?
  fi
}

cd ..
echo $PWD
