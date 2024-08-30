#!/bin/bash

deps=(build-essential curl libfuse2 ripgrep wl-clipboard zip)

for dep in ${deps[@]}; do
  dpkg -s $dep >/dev/null 2>&1
  if [ ! $? -eq 0 ]; then
    echo "$dep is required and was not found, installing..."
    sudo apt install $dep
  fi
done
