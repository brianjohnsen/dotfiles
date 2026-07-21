#!/usr/bin/env bash

set -euxo pipefail

# 1Password CLI (op) - used by backup/backup-1password.sh to push the backup to
# your vault. Installed from 1Password's official apt repo.
# See: https://developer.1password.com/docs/cli/get-started/

if command -v op >/dev/null 2>&1; then
    echo "op CLI already installed"
    exit 0
fi

echo "Installing 1Password CLI (op)..."

# Repo signing key
curl -sS https://downloads.1password.com/linux/keys/1password.asc \
  | sudo gpg --yes --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Apt source
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" \
  | sudo tee /etc/apt/sources.list.d/1password.list

# debsig verification policy
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol \
  | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc \
  | sudo gpg --yes --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update
sudo apt install -y 1password-cli

echo "Done. Enable CLI integration once: 1Password app -> Settings -> Developer"
echo "-> 'Integrate with 1Password CLI' (or run 'op signin')."
