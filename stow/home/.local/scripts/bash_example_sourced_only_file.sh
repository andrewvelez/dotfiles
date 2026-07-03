#! /bin/false
# shellcheck shell=bash
#  by: Andrew Velez 2026

nope() {
    printf '%s\n' "${1}"; exit 2
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  nope "source this file; do not run it"
fi

my_function() {
  :
}