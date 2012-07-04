#!/usr/bin/env bash

set -e

do_something() [[ "$1" == "false" || -z "$1" ]]

if x=$(do_something)
then echo "1:succ:$x:$?"
else echo "1:fail:$x:$?"
fi

if x=$(do_something false)
then echo "2:succ:$x:$?"
else echo "2:fail:$x:$?"
fi

if x=$(do_something true)
then echo "3:succ:$x:$?"
else echo "3:fail:$x:$?"
fi
