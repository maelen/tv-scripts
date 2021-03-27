#!/bin/bash -e

folder=/home/hts/recordings

min_space_left=209715200

files=$(find $folder -type f  ! -iname "*.done"  -printf '%T+ %p\n' | \
                sort | \
                cut -d' ' -f2-)

get_space_left () {
  echo $(df $folder | tr -s ' '| cut -d' ' -f4| tail -n 1)
}

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in $files; do
  space_left=$( get_space_left )
  if [[ $space_left -lt $min_space_left ]]; then
    rm "$f"
  else
    break
  fi
done
