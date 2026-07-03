#! /usr/bin/env bash
#  library functions for my scripts to source
#  by: Andrew Velez 2026


if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "error: this file must be sourced" >&2
  exit 1
fi

_SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "${_SCRIPT_DIR}/is.sh"

# saves the usage heredoc for display later
define_usage() {
  local _ARGV=("$@")
  local _USAGE_TEXT
  _USAGE_TEXT="$(cat)"

  case "${_ARGV[0]:-}" in
    -h|--help)
      printf '%s\n' "$_USAGE_TEXT"
      exit 0
      ;;
  esac

  set -- "${_ARGV[@]}"
}

error() {
  printf 'error: %s\n' "$1" >&2
  exit 1
}
