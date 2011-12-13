#!/bin/zsh

#it works with sh and zsh, but not with bash

alias unless="if !"

unless true
then echo "false?"
else echo "true?"
fi
