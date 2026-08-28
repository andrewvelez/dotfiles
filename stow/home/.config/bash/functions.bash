#! /usr/bin/env bash
#  by: Andrew Velez 2026

help() {
    if builtin help "$@" 2> /dev/null; then
        return 0
    fi

    if [[ $# -eq 1 ]] && command -v -- "$1" > /dev/null 2>&1; then
        "$1" --help
        return
    fi

    builtin help "$@"
}

open_file_editor() {
    code -r "$@" > /dev/null 2>&1
}

# Source - https://stackoverflow.com/a
# Posted by Rucent88
# Retrieved 2025-12-24, License - CC BY-SA 4.0
sudo_plus() {
    [[ "$(type -t "$1")" == "function" ]] && sudo bash -c "$(declare -f "$1"); $*"
}
