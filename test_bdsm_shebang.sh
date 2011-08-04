#!/usr/bin/env bdsm

module_or_error 'backup/scripting'\
  "backup extension not available, install it with: bdsm extend mpapis/bdsm_backup backup"

log "Check https://github.com/mpapis/bdsm_backup for instructions"
