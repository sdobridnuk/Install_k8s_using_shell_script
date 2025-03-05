#!/bin/bash
set -o noglob
for file in `cat .gitignore | grep -v \#`
do
    printf "$file"
    find . -name "$file" | wc -l
done