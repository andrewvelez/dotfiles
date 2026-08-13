#! /bin/bash
#  @author Andrew Velez 2026
#  @summary $HOME/.config/bash/bashrc
#  @summary bashrc is called for all terminal shell (not gui login) from bash_profile

########### Brought in from the rain #############
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

if [[ -x /usr/bin/dircolors ]]; then
    (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
LS_COLORS+=':*!=30;41'
################################################

## Environment Variables
export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.local/cache"
export NVM_DIR="$HOME/.local/nvm"
export BUN_INSTALL="$HOME/.local/bun"
export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
export ANDROID_HOME="$HOME/Android/Sdk"
NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 "$ANDROID_HOME"/ndk)"
export NDK_HOME
export GOPATH="$HOME/.local/go"
export RUBY_HOME="$HOME/.local/share/gem/ruby/3.4.0"
export RUSTFLAGS="-Clink-arg=-z -Clink-arg=nostart-stop-gc"
export RUSTUP_INIT_SKIP_PATH_CHECK="yes"
export RAD_HOME="$HOME/.radicle"
export FILEN_CLI_DATA_DIR="$XDG_CONFIG_HOME/filen-cli"
export DELTA_FEATURES="diff-so-fancy"
export STOW_DIR="$HOME/Code/dotfiles/stow"
export DOTNET_CLI_HOME="$HOME/.local/share/dotnet"
export NUGET_PACKAGES="$HOME/.local/share/nuget/packages"
export DOTNET_ADD_GLOBAL_TOOLS_TO_PATH='false'
export SVDIR="$HOME/.local/service"
export VSCODE_EXTENSIONS="$HOME/.local/share/code-oss/extensions"
export PNPM_HOME="$HOME/.local/share/pnpm"
