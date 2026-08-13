#! /bin/bash
#  @author Andrew Velez 2026
#  @summary $HOME/.config/bash/bashrc
#  @summary bashrc is called for all terminal shell (not gui login) from bash_profile

[ -z "$PS1" ] && return

[[ -r "${HOME}/.config/bash/functions.bash" ]] && . "${HOME}/.config/bash/functions.bash"
[[ -r "${HOME}/.config/bash/environment_variables.bash" ]] && . "${HOME}/.config/bash/environment_variables.bash"
[[ -r "${HOME}/.config/bash/path.bash" ]] && . "${HOME}/.config/bash/path.bash"
[[ -r "${HOME}/.config/bash/sources.bash" ]] && . "${HOME}/.config/bash/sources.bash"
[[ -r "${HOME}/.config/bash/aliases.bash" ]] && . "${HOME}/.config/bash/aliases.bash"

[[ $- == *i* ]] && [[ -r "$HOME/.local/share/blesh/ble.sh" ]] && . "$HOME/.local/share/blesh/ble.sh"
