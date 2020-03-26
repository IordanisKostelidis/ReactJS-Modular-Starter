#!/bin/bash

declare -A args
for val in "$@"
do
  if [[ ${val} == --* ]]; then
    val=$(echo "$val" | cut -f3- -d"-")
  elif [[ ${val} == -* ]]; then
    val=$(echo "$val" | cut -f2- -d"-")
  else
    continue
  fi
  key=$(echo "$val" | cut -f1 -d"=")
  value=$(echo "$val" | cut -f2 -d"=")
  args["$key"]="$value"
done

cur_dir=$(pwd | rev | cut -d"/" -f1 | rev)

if [[ "$cur_dir" == "scripts" ]]; then
  cd ..
fi

echo "Running in $(pwd)"

docker build -f ./docker/Dockerfile -t reactjs-modular-starter-admin --build-arg SITE_TO_BUILD=admin ./
