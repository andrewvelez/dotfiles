#! /usr/bin/env bash
#  @author Andrew Velez 2026
#  This file updates this system only, Andrew's laptop.

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
    printf '%s\n' 'run this file; do not source it' && exit 2
fi

[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"
[[ -r "/etc/bash/bashrc.d/global-functions.sh" ]] && . "/etc/bash/bashrc.d/global-functions.sh"

_is_radicle_running() {
    ssh-add -T <(rad self --ssh-key) >/dev/null 2>&1 && rad node status --only nid >/dev/null 2>&1
}

_update() {
    local __log_dir __log_file __lock_file
    __log_dir="$HOME/.local/state/vupdate-login"
    __log_file="$__log_dir/$(date '+%Y-%m-%d_%H-%M-%S')_$$.log"
    __lock_file="${XDG_RUNTIME_DIR:-/tmp}/vupdate-login.lock"

    mkdir -p "$__log_dir"
    exec 9> "$__lock_file"
    flock -n 9 || exit 0

    if [[ -t 1 ]]; then
        exec > >(tee -a "$__log_file") 2>&1
    else
        exec >> "$__log_file" 2>&1
    fi

    sudo -n /usr/bin/xbps-install -Suy || { printf '%s\n' 'failed to update' && return 1; }
    /usr/bin/flatpak update -y || { printf '%s\n' 'flatpak failed to update' && return 1; }

    if ! _is_radicle_running; then
        RAD_PASSPHRASE="$(secret-tool lookup application radicle key passphrase)"
        export RAD_PASSPHRASE
        rad auth --stdin <<< "${RAD_PASSPHRASE}" || { printf '%s\n' 'Error rad auth' && return 1; }
        rad node start || { printf '%s\n' 'Error rad node start' && return 1; }
    fi
}

_update
