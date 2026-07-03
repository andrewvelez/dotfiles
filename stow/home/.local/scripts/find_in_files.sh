#! /bin/bash
#  by: Andrew Velez 2026

set -E
trap 'rc=$?; echo "error: ${BASH_SOURCE[0]}:${LINENO}: ${BASH_COMMAND} exited with $rc" >&2' ERR
[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_find_in_files() {
    [[ "$#" -eq 1 ]] || { echo 'usage: find_in_files <search_text>  *sudo password required' >&2; return 2; }

    sudo rg -Fi. --no-messages --glob '!**/.var/**' "$1" /home /opt /etc /lib /usr /var/log || [[ $? -eq 1 ]]
}

_find_in_files "$@"