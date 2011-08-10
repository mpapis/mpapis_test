#!/usr/bin/env bash

fun1()
{
  local a='test'
  fun2 inside
}

fun2()
{
  echo "$1:$a:"
}

fun1
fun2 outside