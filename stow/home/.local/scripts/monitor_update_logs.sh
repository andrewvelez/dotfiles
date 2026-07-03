#! /usr/bin/env bash
#  by: Andrew Velez 2026

die() {
    printf '%s\n' "$1" >&2
    exit 2
}

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
    die "run this file; do not source it"
fi

[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_main() {
    local dir day1 day2 log_filter
    dir="${HOME}/.local/state/vupdate-login"

    day1="$(date -d yesterday +%F)"
    day2="$(date -d '2 days ago' +%F)"

    log_filter=( \( -name "${day1}_*.log" -o -name "${day2}_*.log" \) )
    if ! find "${dir}" -maxdepth 1 -type f "${log_filter[@]}" -print -quit | grep -q .; then
        notify-send "Missing logs" "No logs found for the last two full days: ${day2} or ${day1}"
    fi
}

_main "$@"