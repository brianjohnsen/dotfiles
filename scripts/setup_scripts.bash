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

# ufst-op/ufst-ned without a sudo prompt. Copied, not symlinked: sudo ignores
# files in sudoers.d that aren't owned by root. visudo first, since a broken
# sudoers file locks sudo out entirely.
sudo visudo -cf "$HOME/.dotfiles/sudoers/ufst-vpn"
sudo install -m 440 -o root -g root "$HOME/.dotfiles/sudoers/ufst-vpn" /etc/sudoers.d/ufst-vpn
