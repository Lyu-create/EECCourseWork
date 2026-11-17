#!/bin/bash

# use a separate file to store the merged content, so that the original files are not modified
cat "$1" > "$3" # clear the content of the merged file and append the content of the first file to it
cat "$2" >> "$3" # append the content of the second file to the merged file
echo "Merge File is"
cat "$3"

