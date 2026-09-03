#! /bin/bash
#  by: Andrew Velez 2026

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/.bash_path" ]] && . "/home/andrew/.config/bash/.bash_path"

_find_in_files() {
    sudo rg -Fi. --no-messages -g '!**/.var/**' -g '!**/.codex/**' "$1" /home /opt /etc /lib /usr || [[ $? -eq 1 ]]
}

_find_in_files "$@"