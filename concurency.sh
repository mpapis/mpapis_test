#!/usr/bin/env bash

x=( $(seq 10) )

do_echo()
{
  sleep 1
  echo $$:$1
}

z=0

decrease_z()
{
  : $((z--))
}

# Why it does not work ???
trap decrease_z SIGCHLD

for x in ${x[@]}
do
  while :
  do
    if (( z<3 ))
    then
      break
    fi
  done
  : $(( z++ ))
  (
    do_echo $x
    kill -SIGCHLD $PPID
  )&
done
wait
