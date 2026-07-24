#! /bin/bash
#  by: Andrew Velez
#
#  $HOME/.config/bash/bashrc
#  bashrc is called for all terminal shell (not gui login) from bash_profile

[ -z "$PS1" ] && return

[[ -r "${HOME}/.config/bash/functions.bash" ]] && . "${HOME}/.config/bash/functions.bash"

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

if [[ -x /usr/bin/dircolors ]]; then
  (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi
LS_COLORS+=':*!=30;41'

[[ -r "${HOME}/.config/bash/environment_variables.bash" ]] && . "${HOME}/.config/bash/environment_variables.bash"
[[ -r "${HOME}/.config/bash/path.bash" ]] && . "${HOME}/.config/bash/path.bash"

add_dir_path "LD_LIBRARY_PATH" "/usr/local/lib"
add_dir_path "LD_LIBRARY_PATH" "/usr/lib"

# Source all the things!
export POSH_THEME="$HOME/.config/posh/gruvbox.omp.json"
type -t "oh-my-posh" > /dev/null && [[ -r "${POSH_THEME}" ]] && eval "$(oh-my-posh init bash --config "${POSH_THEME}")"
type -t "batman" > /dev/null && eval "$(batman --export-env)"
type -t "jj" > /dev/null && eval "$(jj util completion bash)"
[[ -r "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
[[ -r "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
[[ -r "$HOME/.rbenv/bin/rbenv" ]] && eval "$("$HOME"/.rbenv/bin/rbenv init - --no-rehash bash)"
[[ -r "$HOME/.config/broot/launcher/bash/br" ]] && . "$HOME/.config/broot/launcher/bash/br"

[[ $- == *i* ]] && [[ -r "$HOME/.local/share/blesh/ble.sh" ]] && . "$HOME/.local/share/blesh/ble.sh"

[[ -r "${HOME}/.config/bash/aliases.bash" ]] && . "${HOME}/.config/bash/aliases.bash"
