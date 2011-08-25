#!/usr/bin/env bash

BASE_URL="http://www.polskastacja.pl"

write_bookmark()
{
  if [[ -n "$1" && -n "$2" ]]
  then
    echo "	<bookmark name=\"$2\" url=\"$1\"/>"
  fi
}

process_filter()
{
  curl -sS $BASE_URL$1 -o - |
    grep -E 'radiochannel|/aac_' |
    awk -F '[<>"]' '/radiochannel/ {print $27} /\/aac/ {print $3}' |
    while read title
  do
    read url
    write_bookmark "$url" "$title"
  done
}

filters=()
all=()

while read title
do
  case "$title" in
    (*filter_*)
      filters+=( "$title" )
      ;;
    (*)
      read url
      all+=( "$url=$title" )
      ;;
  esac
done < <(
  curl -sS $BASE_URL/radio -o - |
  grep -E 'radiochannel|/aac_|radio/filter_' |
  awk -F '[<>"]' '/filter_/ {print $7"="$9} /radiochannel/ {print $27} /\/aac/ {print $3}'
)

{
echo "    <group name=\"Wszystkie\">"
for pair in "${all[@]}"
do
  write_bookmark "${pair%%=*}" "${pair#*=}"
done
echo "    </group>"

for pair in "${filters[@]}"
do
  echo "    <group name=\"${pair#*=}\">"
  process_filter "${pair%%=*}"
  echo "    </group>"
done
} | sed 's/&/&amp;/g'
