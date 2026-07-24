#! /usr/bin/env bash
#  @author Andrew Velez 2026
# ~/.config/bash/path.bash

add_dir_path() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        return 1
    fi

    current="${!1}"

    case ":${!1}:" in
        *":${2}:"*) ;;
        *) printf -v "$1" '%s:%s' "$2" "${!1}" ;;
    esac
}
export -f "add_dir_path"

add_dir_path "PATH" "$HOME/.local/bin"
add_dir_path "PATH" "$HOME/AppImages"
add_dir_path "PATH" "$DOTNET_ROOT"
add_dir_path "PATH" "$DOTNET_ROOT/tools"
add_dir_path "PATH" "$RUBY_HOME/bin"
add_dir_path "PATH" "/usr/lib/go/bin"
add_dir_path "PATH" "$GOPATH/bin"
add_dir_path "PATH" "$CARGO_HOME/bin"
add_dir_path "PATH" "$BUN_INSTALL/bin"
add_dir_path "PATH" "$HOME/.local/radicle/bin"

export PATH