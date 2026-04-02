#! /bin/bash
#  by: Andrew Velez
#
#  $HOME/.config/bash/bashrc
#  bashrc is called for all terminal shell (not gui login) from bash_profile

[ -z "$PS1" ] && return

for _bash_file in "$HOME"/.config/bash/bashrc.d/*; do
  [[ -r ${_bash_file} ]] && . "${_bash_file}"
done
unset "_bash_file"

[[ $- == *i* ]] && [[ -r "$HOME/.local/share/blesh/ble.sh" ]] && . "$HOME/.local/share/blesh/ble.sh"
