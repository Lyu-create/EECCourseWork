#!/bin/bash
# Author: Xinyi Lyu xl6226@ic.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs (.tsv) in the file with commas
#       save the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2026

echo "Creating a comma delimited version of $1 ..."

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
output="results/$filename.csv"

if ! tr '\t' ',' < "$1" > "$output"; then
    echo "Error: Conversion failed" >&2
    exit 3
fi

echo "Done!"
