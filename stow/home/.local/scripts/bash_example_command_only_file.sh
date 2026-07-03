#! /usr/bin/env bash
#  by: Andrew Velez 2026

nope() {
    printf '%s\n' "${1}"; exit 2
}

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  nope "run this file; do not source it"
fi

my_function() {
  :
}

my_function "$@"