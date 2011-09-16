#!/usr/bin/env zsh

TRAPEXIT()
{
  echo exit app
}

alias trex='TRAPEXIT(){ echo exit function ; }; echo'

fun1()
{
  trex w00t
  echo $0...
}

fun1
