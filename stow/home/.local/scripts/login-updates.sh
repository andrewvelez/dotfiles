#! /usr/bin/env bash
#  @author Andrew Velez 2026
#  @summary updates this system only, Andrew's laptop.

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

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
    
}

_update "$@"