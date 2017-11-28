#!/bin/bash
path1="/home/austin/ubuntu-lib/cv3.2_1"
path2=
path3=

paths=($path1 $path2 $path3)
for i in ${paths[@]}; do  
  num=$((num + 1))
  echo "$num: ${i}"
done

read -p "Which opencv do you want to LD? " idx
echo "add ${paths[idx]}"
(set -x; export LD_LIBRARY_PATH=${paths[idx]}/lib:$LD_LIBRARY_PATH)
