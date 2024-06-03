#!/bin/bash

# By Abdullah As-Sadeed

while read p; do
  opt_deps=$(pacman -Qi $p | awk '/Optional Deps/{flag=1;next}/Required By/{flag=0}flag' | grep -v "None" | sed 's/\[installed\]/\x1b[32m&\x1b[0m/g' | sed '/\[installed\]/!s/.*/\x1b[33m&\x1b[0m/')
  if [ -n "$opt_deps" ]; then
    echo -e "\x1b[31mPackage: $p\x1b[0m"
    echo -e "$opt_deps"
    echo -e "\n"
  fi
done <pacman_Packages.txt
