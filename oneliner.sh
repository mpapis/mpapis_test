#!/usr/bin/env bash

ol_process() (echo $@)

ol_process process a

ol_python()
  for x in $@
  do echo $x
  done

ol_python  python  b
