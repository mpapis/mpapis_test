#!/usr/bin/env bash

function dotted()
{
  typeset flush
  if awk --version | grep -i gnu >/dev/null
  then flush=flush
  else flush=fflush
  fi
  awk '{printf "."; '$flush'}'
}

seq 10 | dotted
