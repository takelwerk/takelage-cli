#!/bin/sh

if [[ "$1" == "info" ]]; then
  cat takelship.yml
  exit
fi

echo "entering endless loop"
while :; do :; done
