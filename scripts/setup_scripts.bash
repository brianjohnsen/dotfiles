#!/usr/bin/env bash

set -euxo pipefail

echo "Linking scripts..."

# symlink to update_firmware script (-f so re-running is idempotent)
sudo ln -sf "$HOME/.dotfiles/local-bin/update_firmware.sh" /usr/local/bin/updatefirmware
