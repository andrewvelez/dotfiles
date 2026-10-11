#!/bin/bash
# @author Andrew Velez <andrewvelez@outlook.com>
# @license MIT
# @description common file for functions useful for scripts too if you source it

help() {
    if builtin help "$@" 2> /dev/null; then
        return 0
    fi

    if [[ $# -eq 1 ]] && command -v -- "$1" > /dev/null 2>&1; then
        "$1" --help
        return
    fi

    builtin help "$@"
}

open_file_editor() {
    /home/andrew/.local/VSCode-linux-x64/bin/code -r --ozone-platform=wayland \
        --disable-features=WaylandFractionalScaleV1 "$@" > /dev/null 2>&1
}

# Source - https://stackoverflow.com/a
# Posted by Rucent88
# Retrieved 2025-12-24, License - CC BY-SA 4.0
sudo_plus() {
    [[ "$(type -t "$1")" == "function" ]] && sudo bash -c "$(declare -f "$1"); $*"
}

redirect_script_outputs_to_syslog() {
    exec > >(vlogger -t "${1:-no_tag}") 2>&1
}

wait_for_network() {
    local START_TIME="$SECONDS"
    while ! sudo -n /usr/local/libexec/sudo-verify-repo-url > /dev/null; do
        sleep 5
        (( SECONDS - START_TIME > 300 )) && return 1
    done
    return 0
}

safely_source() {
    if [[ $# -ne 1 || ! -f $1 || ! -r $1 ]]; then
        return 1
    fi

    case $1 in
        /*) source -- "$1" ;;
        *)  source -- "./$1" ;;
    esac
}