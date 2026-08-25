#!/usr/bin/env bash

set -euxo pipefail

echo "Linking scripts..."

# symlink to update_firmware script (-f so re-running is idempotent)
sudo ln -sf "$HOME/.dotfiles/local-bin/update_firmware.sh" /usr/local/bin/updatefirmware

# UFST/SKAT tooling -> ~/.local/bin (already on PATH via .bashrc).
# Needs no sudo; ufst-vpn reads its password from ~/.ufst-password, which
# lives outside this repo and is never committed.
mkdir -p "$HOME/.local/bin"
for script in "$HOME"/.dotfiles/local-bin/ufst/ufst-*; do
    ln -sf "$script" "$HOME/.local/bin/$(basename "$script")"
done
