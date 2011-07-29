#!/usr/bin/env bash

export LEVEL=0

function log() {
  printf "%$(( LEVEL * 2 ))s$*\n" ""
}

function fail() {
  local ret=$1
  shift
  printf "FAIL: $*\n"
  exit $ret
}

function cf()
{
  "$@"
  local ret=$?
  if (( $ret == 0 ))
  then
    return $ret
  else
    fail $ret "$@"
  fi
}

function go()
{
  : $(( LEVEL++ ))
  "$@"
  local ret=$?
  : $(( LEVEL-- ))
  return $ret
}

test2()
{
  log 'a 2nd level'
  go test3 x
  log 'b 2nd level'
  cf go test3 y
  log 'c 2nd level'
}

test3()
{
  log "$1 a 3nd level"
  log "$1 b 3nd level"
  return 1
}

log '1st level'
go test2
log 'finish'
