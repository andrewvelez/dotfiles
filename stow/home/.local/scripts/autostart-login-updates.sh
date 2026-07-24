#! /home/andrew/.local/libexec/base-runner
#  shellcheck shell=bash

_sync() {
    local output
    output="$(sudo -n xbps-install -Sy 2>&1)" || return 1
    [[ "$output" != *ERROR* ]]
}

_wait_for_network_resource() {
    local start=$SECONDS

    until _sync; do
        (( SECONDS - start > 300 )) && return 125
        sleep 5
    done
}

_update_with_lock() {
    local lock
    lock="${XDG_RUNTIME_DIR:-/tmp}/login-updates.lock"
    exec 9>"$lock" || return 1
    flock -n 9 || return 0

    exec /home/andrew/.local/bin/login-updates
}

main() {
    exec 2> >(vlogger -t "update_on_login.autostart.sh" -p user.err)
    { _wait_for_network_resource && _update_with_lock; } &
}