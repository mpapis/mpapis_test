#!/usr/bin/env bash

tmp="${TMPDIR:-/tmp}/test quotes and spaces"
mkdir -p "$tmp/"
touch "$tmp/a.rb"
touch "$tmp/b.rb"

IFS=
for f in $tmp/*.rb
do
  echo "$f"
done

rm -rf "$tmp"
