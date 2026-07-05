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
        *)
            return 1
            ;;
    esac
}

_up() {
    local CONF_FILE
    CONF_FILE="$1"

    [[ -r "${CONF_FILE}" ]] || { echo 'Wireguard configuration file does not exist.' >&2; return 2; }

    if sudo wg-quick up "${CONF_FILE}" > /dev/null && _is_connected; then
        return 0
    else
        echo 'Failed to connect with wg-quick'
        return 1
    fi
}

_down() {
    sudo find /etc/wireguard -maxdepth 1 -type f -name '*.conf' -exec wg-quick down {} > /dev/null \;
}

_list() {
    local CONF_FILE

    for CONF_FILE in /etc/wireguard/*.conf; do
        printf '%s\n' "${CONF_FILE}"
    done
}

_mullvad_wg() {
    case "$1" in
        "up")
            if [[ "$#" -eq 2 ]]; then
                _up "$2"
            else
                echo 'usage: sudo mullvad_wg (up|down|list) [conf_file]'
                return 2
            fi
            ;;
        "down")
            _down
            ;;
        "list")
            _list
            ;;
        *)
            echo 'usage: sudo mullvad_wg (up|down|list) [conf_file]' >&2
            return 2
            ;;
    esac
}

_mullvad_wg "$@"
