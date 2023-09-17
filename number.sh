#!/bin/bash

x=qustuntunia
grep -o "u" <<< "$x" | wc -l
