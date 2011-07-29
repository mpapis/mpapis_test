#!/usr/bin/env bash

shopt -s extglob

term='^[[:alnum:]_-]+\/[[:alnum:]_-]+$'

match1()
{
  echo "$1" | grep -E "$2" > /dev/null
}

match1

if match1 "$1" "$term"
then
  echo '1 match'
else
  echo '1 fail'
fi

match2()
{
  shopt -s extglob
  case "$1" in
  ($2)
    return 0;
    ;;
  (*)
    return 1;
    ;;
  esac
}

if match2 "$1" "$term"
then
  echo '2 match'
else
  echo '2 fail'
fi

case $1 in
  ("$term")
    echo github $1
    ;;
  (/*)
    echo fs $1
    ;;
  (*git|git*)
    echo git $1
    ;;
  (*)
    echo unknown $1
    ;;
esac
