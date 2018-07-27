#!/bin/sh

realpath() {
  ourpwd=$PWD
  cd "$(dirname "$1")"
  link=$(readlink "$(basename "$1")")
  while [ "$link" ]; do
    cd "$(dirname "$link")"
    link=$(readlink "$(basename "$1")")
  done
  realpath="$PWD/$(basename "$1")"
  cd "$ourpwd"
  echo "$realpath"
}

p=$(dirname "$(realpath $0)")

sudo $p/hid_listen | $p/kb_mode ~/.current_layer
