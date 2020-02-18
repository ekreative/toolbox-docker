#!/usr/bin/env bash
set -e

# See latest version at https://github.com/helm/helm/releases
declare -A helm=(
  ['2']='2.16.3'
	['3']='3.1.0'
)

for helmVariant in "${!helm[@]}"; do
  template="Dockerfile.template"
  dir="helm-$helmVariant"
  rm -rf "$dir"
  mkdir -p "$dir"
  cp docker-config.json "$dir/"

  extraSed=''
  if [ "$helmVariant" != "2" ]; then
    extraSed='
      '"$extraSed"'
      /##<helm2>##/,/##<\/helm2>##/d;
    '
  fi
  if [ "$helmVariant" != "3" ]; then
    extraSed='
      '"$extraSed"'
      /##<helm3>##/,/##<\/helm3>##/d;
    '
  fi
  sed -E '
    '"$extraSed"'
    s/%%HELM_VARIANT%%/'"${helm[$helmVariant]}"'/;
  ' $template > "$dir/Dockerfile"
done
