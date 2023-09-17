#!/bin/bash
#################################
# Author : owes shah
# Date   : 17-09-2023
# version: v1
################################

# divisible by 3 & 5, but not by 3*5=15

for i in {1..100}; do
  if ((i % 3 == 0 || i % 5 == 0)) && ((i % 15 != 0)); then
    echo $i
  fi
done

