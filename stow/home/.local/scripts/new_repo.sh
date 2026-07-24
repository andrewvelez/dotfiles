#! /bin/bash
#  by: Andrew Velez 2026

[[ ${BASH_SOURCE[0]} == "$0" ]] || { echo 'run this file; do not source it' >&2; return 2; }
[[ -r "/home/andrew/.config/bash/path.bash" ]] && . "/home/andrew/.config/bash/path.bash"

_new_repo() {
    local owner repo
    owner="andrewvelez"

    if [[ "${EUID}" -eq 0 ]] || [[ "$#" -ne 1 ]]; then
        echo "usage: ${0##*/} <repo-name> (do not use sudo)" >&2
        exit 1
    fi

    repo="$1"
    if ! [[ "$repo" =~ ^[A-Za-z0-9._-]+$ ]]; then
        echo "error: invalid repo name: $repo" >&2
        exit 1
    fi

    mkdir -p "$HOME/Code/$repo"
    cd "$HOME/Code/$repo" || return

    git init -b main > /dev/null
    git commit --allow-empty -m "Initial commit" > /dev/null
    gh repo create "$owner/$repo" --public --source=. --remote=origin --push > /dev/null
    rad init --name "$repo" --description "$repo" --default-branch main --private --no-confirm > /dev/null

    git config --unset-all remote.origin.pushurl > /dev/null || true
    git remote set-url --add --push origin "git@github.com:$owner/$repo.git" > /dev/null
    git remote set-url --add --push origin "$(git remote get-url --push rad)" > /dev/null
}

_new_repo "$@"