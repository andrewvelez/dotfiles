#!/bin/sh
#  by: Andrew Velez

_logged_err_message="Error running xpkg -m > manual_packages"
_pkgs_backup_file="/home/andrew/Code/.devbox/manual_packages"

if ! xpkg -m > "${_pkgs_backup_file}"; then
  printf '%s\n' "${_logged_err_message}" |
    vlogger -p cron.err -t manual_packages_backup
  exit 1
fi