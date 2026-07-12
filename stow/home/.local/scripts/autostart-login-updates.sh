#! /usr/bin/env bash
#  @author Andrew Velez 2026
#  @summary autostart script to wait for network before running login-updates.sh

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_sync() {
    local output exit_code
    output="$(sudo -n xbps-install -Sy 2>&1)"
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

_tryNetworkWithTimeout() {
    local timeout start
    timeout=300
    start=$SECONDS

    while true; do
        if [[ "$((SECONDS - start))" -gt "$timeout" ]]; then
            return 125
        fi

        if _sync; then
            return 0
        else
            sleep 5
        fi
    done
}

_main() {
    logger -t "update_on_login.autostart.sh" "script started"
    exec 2> >(vlogger -t "update_on_login.autostart.sh" -p user.err)

    local lock
    lock="${XDG_RUNTIME_DIR:-/tmp}/login-updates.lock"
    exec 9>"$lock" || return 1
    flock -n 9 || return 0

    _tryNetworkWithTimeout || return "$?"
    exec /home/andrew/.local/bin/login-updates
}

_main "$@"
