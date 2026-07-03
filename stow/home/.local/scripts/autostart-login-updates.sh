#! /usr/bin/env bash
#  @author Andrew Velez 2026
#  autostart script to wait for network before running login-updates.sh

set -eu
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"
exec 2> >(vlogger -t "autostart-login-updates" -p user.err)

lock="${XDG_RUNTIME_DIR:-/tmp}/login-updates.lock"
exec 9>"$lock"
flock -n 9 || exit 0

until curl -fsS --max-time 10 https://repo-default.voidlinux.org/current/x86_64-repodata > /dev/null; do
    sleep 15
done

exec /home/andrew/.local/bin/login_update