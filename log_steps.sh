#!/usr/bin/env bdsm

failing()
{
  echo "function failed $*"
  false
}

log_step "Works1" echo "success"
log_step "Fails1" failing fun1
log_step "Works2" echo "win"
log_step "Fails2" failing fun2
