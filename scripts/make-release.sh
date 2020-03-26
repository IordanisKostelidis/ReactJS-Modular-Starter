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

if [[ -z "${args['version']}" ]]; then
  args['version']="master-SNAPSHOT"
fi

cur_dir=$(pwd | rev | cut -d"/" -f1 | rev)

if [[ "$cur_dir" == "scripts" ]]; then
  cd ..
fi

echo "Running in $(pwd)" \
  && yarn \
  && yarn clean-components \
  && yarn lint-components \
  && yarn coverage-components \
  && yarn build-components \
  && yarn clean-sites \
  && yarn lint-sites \
  && yarn coverage-sites \
  && yarn build-sites

VERSION="$(date +"%Y.%m.%d-%H%M%S")"

mkdir ./releases
mkdir ./releases/"${VERSION}"

cp -r ./packages/reactjs-modular-starter-portal/build ./releases/"${VERSION}"/portal
cp -r ./packages/reactjs-modular-starter-admin/build ./releases/"${VERSION}"/admin

cd ./releases/"${VERSION}"

tar -czvf portal-"${VERSION}".tar.gz ./portal
tar -czvf admin-"${VERSION}".tar.gz ./admin

rm -fr ./portal
rm -fr ./admin
