#!/usr/bin/env bash

test_ERR()
{
  echo lol
  exit 1
}

fun1()
{
  w--o
}

fun2()
{
  "$@"
}

fun3()
{
  #set -o errexit
  set -o errtrace
  trap test_ERR ERR

  echo $SHELLOPTS
  ls ala
  fun2 echo a
  fun2 fun1
  fun2 echo b
}

fun2 fun3
