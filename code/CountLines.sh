#!/bin/bash

NumLines=`wc -l < "$1"` #  wc -l counts the number of lines in a file, < "$1" redirects the contents of the file to wc -l, and the backticks `` capture the output of the command and assign it to the variable NumLines.
echo "The file $1 has $NumLines lines"
echo