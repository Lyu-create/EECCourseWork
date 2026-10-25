#!/bin/bash
# Author: Xinyi Lyu xl6226@ic.ac.uk
# Script: csvtospace.sh
# Desc: substitute the comma in the file with space
#       save the output into a .txt file
# Arguments: 1-> comma delimited file
# Date: Oct 2026

echo "Creating a space delimited version of $1 ..."

# Check if theres only one input file, mutliple files will create an error
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one input file" >&2
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: File '$1' can not be read" >&2
    exit 2
fi

mkdir -p results

filename=$(basename "$1")
output="results/$filename.txt"

if ! tr ',' ' ' < "$1" > "$output"; then
    echo "Error: Conversion failed" >&2
    exit 3
fi

echo "Done!"