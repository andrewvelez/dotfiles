#! /bin/bash
#  by: Andrew Velez
#
#  $HOME/.config/bash/bashrc
#  bashrc is called for all terminal shell (not gui login) from bash_profile

[ -z "$PS1" ] && return

# region Functions

services-status() {
  local _svdir="${SVDIR:-/var/service}"
  sudo sv check "${_svdir}"/*
}
export -f "services-status"

test-substring() {
  case "$1" in
    *"$2"*) return 0 ;;
    *) return 1 ;;
  esac
}
export -f "test-substring"

add-path-dir() {
  # add-path-dir func must remain with {} because it's modifying PATH

  if [ -z "$1" ] || ! [ -d "$2" ]; then
    return 1
  fi

  if ! test-substring ":${!1}:" ":${2}:"; then
    eval "$1=\"${2}:${!1}\""
  fi
}
export -f "add-path-dir"

open-file-editor() (
  /bin/code-oss -r "$@" > /dev/null 2>&1
)
export -f "open-file-editor"

# Name: get-logs
# Desc: Get logs for the passed in params that is paged and reversed.
# Param [_logfile]: Which log file, default is everything/current
# Param [_numlines]: How many lines of the log to grab, default is 5000
# Param [_optgrep]: Options to pass straight to grep
get-logs() (
  local _logfile="${1:-/var/log/socklog/everything/current}"
  local _numlines="${2:-5000}"
  local _optgrep="${3}"

  if [[ -z ${_optgrep} ]]; then
    tail -n "${_numlines}" "${_logfile}" | tac | bat -l log
  else
    tail -n "${_numlines}" "${_logfile}" | tac | grep -F "${_optgrep}" | bat -l log
  fi
)
export -f "get-logs"

# Source - https://stackoverflow.com/a
# Posted by Rucent88
# Retrieved 2025-12-24, License - CC BY-SA 4.0
sudo_plus() {
  [[ "$(type -t "$1")" == "function" ]] && sudo bash -c "$(declare -f "$1"); $*"
}
export -f "sudo_plus"

get-bash-variables() (
  declare -p | grep -Eiv '^.*?_?ble.*?$'
)
export -f "get-bash-variables"

# endregion Functions

# region Environment

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

if [[ -x /usr/bin/dircolors ]]; then
  (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.local/nvm"
export BUN_INSTALL="$HOME/.local/bun"
export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
export GOPATH="$HOME/.local/go"
export RUBY_HOME="$HOME/.local/share/gem/ruby/3.4.0"
export RUSTFLAGS="-Clink-arg=-z -Clink-arg=nostart-stop-gc"
export RUSTUP_INIT_SKIP_PATH_CHECK="yes"
export RAD_HOME="$HOME/.radicle"

add-path-dir "PATH" "$HOME/.local/bin"
add-path-dir "PATH" "$DOTNET_ROOT"
add-path-dir "PATH" "$DOTNET_ROOT/tools"
add-path-dir "PATH" "$RUBY_HOME/bin"
add-path-dir "PATH" "/usr/lib/go/bin"
add-path-dir "PATH" "$GOPATH/bin"
add-path-dir "PATH" "$CARGO_HOME/bin"
add-path-dir "PATH" "$BUN_INSTALL/bin"
add-path-dir "PATH" "$HOME/.local/radicle/bin"
add-path-dir "PATH" "/opt/fil/bin"

add-path-dir "XDG_DATA_DIRS" "/var/lib/flatpak/exports/share"
add-path-dir "XDG_DATA_DIRS" "$HOME/.local/flatpak/exports/share"

# Source all the things!
type -t "oh-my-posh" > /dev/null && [[ -r "$HOME/.config/posh/onehalf.modified.omp.json" ]] && eval "$(oh-my-posh init bash --config "$HOME"/.config/posh/onehalf.modified.omp.json)"
type -t "batman" > /dev/null && eval "$(batman --export-env)"
type -t "jj" > /dev/null && eval "$(jj util completion bash)"
[[ -r "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
[[ -r "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
[[ -r "$HOME/.rbenv/bin/rbenv" ]] && eval "$("$HOME"/.rbenv/bin/rbenv init - --no-rehash bash)"
[[ -r "$HOME/.config/broot/launcher/bash/br" ]] && . "$HOME/.config/broot/launcher/bash/br"

# identity daemons
eval "$(ssh-agent -s)" > /dev/null

# endregion Environment

# region Aliases

alias ls='ls --color=auto'
alias l='ls -Al'
alias ll='ls -AlL'
alias where='whereis'
alias sudo='sudo '
alias e='open-file-editor'
alias cat='bat --paging=never'
alias bm='bashmatic'

# directory shortcuts
alias ph='cd $HOME; clear'
alias lbin='cd $HOME/.local/bin'

# void specific
alias vadd='sudo xbps-install -S '
alias vfind='sudo xbps-query -Rs '
alias vdel='sudo xbps-remove '
alias vupdate='sudo xbps-install -Su; flatpak update '
alias vsrv='services-status'

# git
alias gc='git commit -a -m '
alias gs='git status'
alias gpush='git pull; git push; gs '

# python
alias python='python3 '

# endregion Aliases

[[ $- == *i* ]] && [[ -r "$HOME/.local/share/blesh/ble.sh" ]] && . "$HOME/.local/share/blesh/ble.sh"

### If packages add anything below this line, please move it into ~/.config/bash/bashrc.d ###
