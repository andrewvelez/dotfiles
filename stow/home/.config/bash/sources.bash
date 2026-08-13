#! /bin/bash
#  @author Andrew Velez 2026
#  @summary $HOME/.config/bash/bashrc
#  @summary bashrc is called for all terminal shell (not gui login) from bash_profile

# Source all the things!
export POSH_THEME="$HOME/.config/posh/gruvbox.omp.json"
type -t "oh-my-posh" >/dev/null && [[ -r "${POSH_THEME}" ]] && eval "$(oh-my-posh init bash --config "${POSH_THEME}")"
type -t "batman" >/dev/null && eval "$(batman --export-env)"
type -t "jj" >/dev/null && eval "$(jj util completion bash)"
[[ -r "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
[[ -r "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
[[ -r "$HOME/.rbenv/bin/rbenv" ]] && eval "$("$HOME"/.rbenv/bin/rbenv init - --no-rehash bash)"
[[ -r "$HOME/.config/broot/launcher/bash/br" ]] && . "$HOME/.config/broot/launcher/bash/br"
[[ -r "$HOME/.vite-plus/env" ]] && . "$HOME/.vite-plus/env"
