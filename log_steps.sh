#!/usr/bin/env bdsm

failing()
{
  echo "function failed 1" >&2
  echo "function failed $*"
  echo "function failed 3" >&2
  echo "function failed 4"
  false
}

log_step "Works1" echo "success"
log_step "Fails1" failing fun1
log_step "Works2" echo "win"
log_step "Fails2" failing fun2
