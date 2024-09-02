#!/usr/bin/env bash

shopt -s lastpipe

tmpdir=$(mktemp -d)
trap 'rm -rf $tmpdir' EXIT
cp -r . "$tmpdir"
cd "$tmpdir" || exit 2
sha256sum flake.lock | awk '{print $1}' | read INITIAL_SUM
nix flake update 2>/dev/null 3>/dev/null
[ "$(sha256sum flake.lock | awk '{print $1}')" == "$INITIAL_SUM" ] &&  echo "No updates needed" && exit 0
echo "Updates needed" >&2 && exit 1
