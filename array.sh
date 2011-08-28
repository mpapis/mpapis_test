#!/usr/bin/env bash

arr=( a b c d )
var=arr
echo "4=${#arr[@]} :${arr[*]}:"

unset arr[$(( ${#arr[@]} - 1 ))]
echo "3=${#arr[@]} :${arr[*]}:"

unset arr[0]
echo "2=${#arr[@]} :${arr[*]}: \${arr[0]}=${arr[0]} \${arr[1]}=${arr[1]} \${arr[2]}=${arr[2]}"
arr=( ${arr[@]} ) #required as array is not reindexed after unset
echo "2=${#arr[@]} :${arr[*]}: \${arr[0]}=${arr[0]} \${arr[1]}=${arr[1]} \${arr[2]}=${arr[2]}"

eval "unset ${var}[0]; ${var}=( \${${var}[@]} )"
echo "1=${#arr[@]} :${arr[*]}:"
