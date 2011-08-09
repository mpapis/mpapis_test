#!/usr/bin/env bash

bash --noprofile --rcfile <(echo "
  source $HOME/.bashrc
  export PS1='(bdsm) [ret=\$?] \w > '
") -i
