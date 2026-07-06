#! /usr/bin/env bash
#  @author Andrew Velez 2026
#  autostart script to wait for network before running login-updates.sh

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_sync() {
    local output exit_code
    output="$(xbps-install -Sy 2>&1)"
    exit_code="$?"

    if [[ "$exit_code" -eq 0 ]]; then
        case "$output" in
            *ERROR*)
                return 1
                ;;
            *)
                return 0
                ;;
        esac
    else
        return 1
    fi
}

_main() {
    exec 2> >(vlogger -t "autostart-login-updates" -p user.err)

    local lock
    lock="${XDG_RUNTIME_DIR:-/tmp}/login-updates.lock"
    exec 9>"$lock"
    flock -n 9 || return 0

    local timeout start
    timeout=300
    start=$SECONDS

    local exit_code
    exit_code=1
    while [[ "$((SECONDS - start))" -lt "$timeout" ]]; do
        if _sync; then
            exit_code=0
            break
        else
            sleep 5
            continue
        fi
    done

    if [[ "$exit_code" -eq 0 ]]; then
        exec /home/andrew/.local/bin/login_update
    else
        echo "Network unavailable after 5 minutes" >&2
    fi

    return "$exit_code"
}

_main "$@"
