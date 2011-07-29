#!/usr/bin/env bdsm

#Load backup framework
module_or_error "backup/scripting" \
  "backup extension not available, install it with:  bdsm extend mpapis/bdsm_backup backup"

# Example backup script uncomment samples bellow for quick start

#initial target backup dir
backup_dir ~/tmp/test

#backup file name
#NAME=webistrano

#example of mysql backup
#MYSQL_PARAMS='-u backup -pbackup_password'
##PREFIX=backup
#SUFFIX=db
#dump_mysql
#rotate 3

#example local file system backup
#SUFFIX=fs
#dump_dir -C ~/tmp/ $NAME
#rotate 4

#example of external incremental backup
#ssh_incr localhost ~/tmp/from 2 ~/tmp/to/
