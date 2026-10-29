#!/bin/bash

if [[ $# -ne 1]]; then
    printf'Usage: %s oak|pine\n' "$0" >&2
    exit 2
fi

