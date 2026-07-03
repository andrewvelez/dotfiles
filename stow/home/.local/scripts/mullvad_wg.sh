#! /bin/bash
#  by: Andrew Velez 2026

[[ "${BASH_SOURCE[0]}" == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_is_connected() {
    local connect_message
    connect_message="$(curl -s https://am.i.mullvad.net/connected)"
    echo "${connect_message}"
    
    case "${connect_message}" in
        "You are connected"*)
            return 0
            ;;
        "You are not connected"*)
            return 1
            ;;
        *)
            exit 1
            ;;
    esac
}

_up() {
    local exit_code conf
    exit_code=1

    for conf in /etc/wireguard/*.conf; do
        [[ -r "${conf}" ]] || continue

        if wg-quick up "$conf" 2> /dev/null && _is_connected; then
            exit_code=0
            break;
        else
            echo "Failed to connect with wg-quick"
            continue;
        fi
    done

    return "$exit_code"
}

_down() {
    local conf

    for conf in /etc/wireguard/*.conf; do
        [[ -r "${conf}" ]] || continue

        wg-quick down "${conf}" 2> /dev/null
    done
}

_mullvad_wg() {
    [[ "$#" -eq 1 ]] || { echo 'usage: sudo mullvad_wg (up|down)' >&2; return 2; }
    [[ "${EUID}" -eq 0 ]] || { echo 'Must run this script as sudo.' >&2; return 1; }

    case "$1" in
        "up")
            _up
            ;;
        "down")
            _down
            ;;
        *)
            echo 'usage: sudo mullvad_wg (up|down)' >&2; return 2;
            ;;
    esac
}

_mullvad_wg "$@"
