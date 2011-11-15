#!/bin/bash

# Examples:
#   ./do_it_once_wrapper.sh
#   ./do_it_once_wrapper.sh 4 echo a
#   ./do_it_once_wrapper.sh 5 __output

__setup()
{
  export __counter
  true ${__counter:=0}
  if (( __counter == 0 ))
  then
    echo "Starting once"
    export TEST_ME="something"
  fi
  echo "__start __counter=${__counter}"
  true $((__counter++))
}

__teardown()
{
  export __counter
  true ${__counter:=0}
  true $((__counter--))
  echo "__end __counter=${__counter}"
  if (( __counter == 0 ))
  then
    echo "Finishing once"
  fi
}

__setup_wrap()
{
  __setup
  "$@"
  __teardown
}

__output()
{
  echo "__output:${__counter}:${TEST_ME}:"
}

if [[ -n "$1" ]] && (( __counter < $1 ))
then
  __setup
  (
    __setup
    __setup
    bash $0 $@
  )
  __teardown

elif [[ -n "$1" ]]
then
  shift # the count
  __setup_wrap $@

elif [[ -z "$1" ]]
then
  __setup_wrap $0 __setup_wrap $0 __setup_wrap __output

fi
