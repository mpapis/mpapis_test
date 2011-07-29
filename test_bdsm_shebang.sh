#!/usr/bin/env bdsm

if module 'backup'
then
  log "Check https://github.com/mpapis/bdsm_backup for instructions"
else
  error "backup extension not available, install it with: "\
    "bdsm extend mpapis/bdsm_backup backup"
fi
