#!/bin/bash

if [[ $# -ne 1 ]]; then # when the arguments are not equal to 1
    printf 'Usage: %s oak|pine\n' "$0" >&2 # sends the usage message to standard error
    exit 2
fi # marking the end of the if statement

if [[ $1 != "oak" && $1 != "pine" ]]; then # when the first argument is not equal to oak and not equal to pine
    printf 'Unknown label: %s\n' "$1" >&2
    exit 1
fi

printf 'Selected species: %s\n' "$1" # runs no matter if the if statement is true or false
# exit 0 when equal to 1 and is oak or pine, not satsifying the if statements