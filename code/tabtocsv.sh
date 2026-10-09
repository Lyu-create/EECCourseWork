#!/bin/bash
# Author: Xinyi Lyu xl6226@ic.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the file with commas
#       save the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2026

echo "Creating a comma delimited version of $1 ..."

# Check if theres only one input file, mutliple files will create an error
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly on input file" >&2
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: File '$1' can not be read"
    exit 2
fi

mkdir -p ~/Documents/EECCourseWork/results

tr "\t" "," < "$1" > ~/Documents/EECCourseWork/results/"$1".csv

echo "Done!"

# The rerun appends to the previous, creating a copy of the previous run.
# It is caused by ">>"

#printf 'oak\t\t12\n' | tr -s '\t' ','
#printf 'oak\t\t12\n' | tr '\t' ','

#cp "$shell_practice/test.txt" "$shell_practice/field notes.txt"
#bash tabtocsv.sh "$shell_practice/field notes.txt"
#echo "$?"

#sample_pattern="$shell_practice/*.txt"
#printf '<%s>\n' "$sample_pattern"
#printf '<%s>\n' $sample pattern