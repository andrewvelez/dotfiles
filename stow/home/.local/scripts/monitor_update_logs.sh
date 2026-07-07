#! /usr/bin/env bash
#  by: Andrew Velez 2026

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_main() {
    local dir day0 day1 day2 log_filter
    dir="${HOME}/.local/state/vupdate-login"

    day1="$(date -d today +%F)"
    day1="$(date -d yesterday +%F)"
    day2="$(date -d '2 days ago' +%F)"

    log_filter=( \( -name "${day0}_*.log" -o -name "${day1}_*.log" -o -name "${day2}_*.log" \) )
    if ! find "${dir}" -maxdepth 1 -type f "${log_filter[@]}" -print -quit | grep -q .; then
        notify-send "Missing logs" "No logs found in 3 days."
    fi
}

_main "$@"