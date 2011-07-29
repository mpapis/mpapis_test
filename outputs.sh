#!/usr/bin/env bash

function_stack()
{
  local IFS=' ' stack=()
  shift
  while (( $# > 1 ))
  do
    stack=("$1" "${stack[@]}")
    shift
  done
  printf "${stack[*]}"
}
function echof()
{
  echo "$(function_stack "${FUNCNAME[@]}"): $*"
}

echof "testujemy1"
function ala()
{
  echof "testujemy2a"
  ma
}
function ma()
{
  echof "testujemy2b"
  kota
}
function kota()
{
  echof "testujemy2c"
}
ala
echof "testujemy3"
