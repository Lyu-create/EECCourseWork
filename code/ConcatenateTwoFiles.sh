#!/bin/bash

cat "$1" > "$3"
cat "$2" >> "$3"
echo "Merge File is"
cat "$3"

#printf 'oak\n' > "$shell_practice/first.txt"
#printf 'pine\n' > "$shell_practice/second.txt"
#bash ConcatenateTwoFiles.sh "$shell_practice/first.txt" "$shell_practice/second.txt" "$shell_practice/combined.txt"