#!/usr/bin/env bash

set -euxo pipefail

# git open
echo "Installing git-open"

# Clone to a temp dir so we never litter the repo root, and so a failed clone
# aborts (set -e) instead of running `make install` in the wrong directory.
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

git clone git@github.com:brianjohnsen/git-open.git "$TMP/git-open"
sudo make -C "$TMP/git-open" install
