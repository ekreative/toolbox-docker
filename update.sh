#!/usr/bin/env bash
set -e

# See latest version at https://github.com/helm/helm/releases
declare -A helm=(
  ['3']='3.9.0'
)

for helmVariant in "${!helm[@]}"; do
  template="Dockerfile.template"
  dir="helm-$helmVariant"
  rm -rf "$dir"
  mkdir -p "$dir"
  cp docker-config.json "$dir/"
  cp "$template" "$dir/Dockerfile"
done
