#!/bin/bash
# Author: Xinyi Lyu xl6226@ic.ac.uk
# Script: csvtospace.sh
# Desc: substitute the comma in the file with space
#       save the output into a .txt file
# Arguments: 1-> tab delimited file
# Date: Oct 2026

echo "Creating a space delimited version of $1 ..."

# Check if theres only one input file, mutliple files will create an error
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly on input file" >&2
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: File '$1' can not be read"
    exit 2
fi

filename=$(basename "$1")

mkdir -p ~/Documents/EECCourseWork/results

tr "," " " < "$1" > ~/Documents/EECCourseWork/results/"$filename".txt

echo "Done!"