#!/bin/bash

#######################################################
# Author : Owes Shah
# Date   : 16-09-2-2023
# The script outputs the nodehealt
# version: v1
#######################################################

set -x #debug mode
set -e #exit the script when an error occured
set -o pipefail
df  -h

free  -g

nproc


ps -ef | grep "amazon" | awk -F " " '{print $2}'
