#! /bin/bash
#  @author Andrew Velez 2026
#  @summary $HOME/.config/bash/bashrc
#  @summary bashrc is called for all terminal shell (not gui login) from bash_profile

[ -z "$PS1" ] && return

[[ -r "${HOME}/.config/bash/.bash_functions" ]] && . "${HOME}/.config/bash/.bash_functions"
[[ -r "${HOME}/.config/bash/.bash_env" ]] && . "${HOME}/.config/bash/.bash_env"
[[ -r "${HOME}/.config/bash/.bash_path" ]] && . "${HOME}/.config/bash/.bash_path"
[[ -r "${HOME}/.config/bash/.bash_sourced" ]] && . "${HOME}/.config/bash/.bash_sourced"
[[ -r "${HOME}/.config/bash/.bash_aliases" ]] && . "${HOME}/.config/bash/.bash_aliases"

[[ $- == *i* ]] && [[ -r "$HOME/.local/share/blesh/ble.sh" ]] && . "$HOME/.local/share/blesh/ble.sh"
