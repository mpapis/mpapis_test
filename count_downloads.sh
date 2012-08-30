#!/usr/bin/env bash

curl -sS https://api.github.com/repos/${1:-railsinstaller/railsinstaller-nix}/downloads |
awk -F": |\"|," '
  BEGIN {
    sum=0;
  }
  $1=="    " && $2=="html_url" {
    gsub(/.*\//,"",$5);
    url=$5;
  }
  $1=="    " && $2=="download_count" {
    count=$4;
  }
  $1=="  }" {
    print url" "count;
    sum+=count;
  }
  END {
    print sum;
  }
'
