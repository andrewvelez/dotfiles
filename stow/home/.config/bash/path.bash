#! /usr/bin/env bash
#  @author Andrew Velez 2026
# ~/.config/bash/path.bash

_add_dir() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        return 1
    fi

    current="${!1}"

    case ":${!1}:" in
    *":${2}:"*) ;;
    *) printf -v "$1" '%s:%s' "$2" "${!1}" ;;
    esac
}
export -f "_add_dir"

_add_dir "PATH" "$HOME/.local/bin"
_add_dir "PATH" "$HOME/AppImages"
_add_dir "PATH" "$DOTNET_ROOT"
_add_dir "PATH" "$DOTNET_ROOT/tools"
_add_dir "PATH" "$RUBY_HOME/bin"
_add_dir "PATH" "/usr/lib/go/bin"
_add_dir "PATH" "$GOPATH/bin"
_add_dir "PATH" "$CARGO_HOME/bin"
_add_dir "PATH" "$BUN_INSTALL/bin"
_add_dir "PATH" "$HOME/.local/radicle/bin"
_add_dir 'PATH' "/opt/android-studio/bin"
_add_dir 'PATH' "$PNPM_HOME/bin"
_add_dir 'PATH' "$HOME/.local/odin"
_add_dir 'PATH' "$HOME/.local/VSCode-linux-x64"

_add_dir "LD_LIBRARY_PATH" "/usr/local/lib"
_add_dir "LD_LIBRARY_PATH" "/usr/lib"

export PATH
export LD_LIBRARY_PATH
