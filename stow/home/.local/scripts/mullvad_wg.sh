#! /bin/bash
#  by: Andrew Velez 2026

set -o pipefail

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/.bash_path" ]] && . "/home/andrew/.config/bash/.bash_path"

_is_connected() {
    local connect_message
    connect_message="$(curl -s https://am.i.mullvad.net/connected)"
    
    case "${connect_message}" in
        *'You are connected'*)
            echo "$connect_message"
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

_up() {
    local conf_file
    conf_file="$(sudo find /etc/wireguard -maxdepth 1 -type f -name "*${1}*.conf" -print -quit)"

    if [[ -n "${conf_file}" ]] && sudo wg-quick up "${conf_file}"; then
        if _is_connected; then
            return 0
        fi
        sudo wg-quick down "${conf_file}"
    fi
    echo 'Failed to establish a verified Mullvad connection' >&2
    return 1
}

_down() {
    local interface interfaces status=0

    if ! interfaces="$(sudo wg show interfaces)"; then
        return 1
    fi
    for interface in $interfaces; do
        if ! sudo wg-quick down "$interface"; then
            status=1
        fi
    done
    return "$status"
}

_list() {
    sudo find /etc/wireguard -maxdepth 1 -name '*.conf' -printf '%p\t%f\n' |
        awk -F '\t' '{ split($2, name, "-"); print $1 "\t" name[2] }' |
        column -t -s $'\t'
}

_usage() {
    echo 'usage: mullvad_wg (up|down|list) [conf_file]'
}

_mullvad_wg() {
    case "$1" in
        "up")
            if [[ "$#" -eq 2 ]]; then
                _up "$2"
            else
                _usage && return 2
            fi
            ;;
        "down")
            _down
            ;;
        "list")
            _list
            ;;
        *)
            _usage && return 2
            ;;
    esac
}

_mullvad_wg "$@"
