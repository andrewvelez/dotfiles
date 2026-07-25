#! /home/andrew/.local/libexec/base-runner
#  shellcheck shell=bash

_update_with_lock() {
    local lock
    lock="${XDG_RUNTIME_DIR:-/tmp}/login-updates.lock"
    exec 9>"$lock" || return 1
    flock -n 9 || return 0

    exec /home/andrew/.local/bin/login-updates
}

main() {
    exec 2> >(vlogger -t "update_on_login.autostart.sh" -p user.err)
    { _wait_network_ready && _update_with_lock; } &
}