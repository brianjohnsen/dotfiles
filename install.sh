#!/usr/bin/env bash

set -euo pipefail

# Run from the repo root regardless of the caller's working directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Log everything (commands + output) to install.log and the console.
# Each setup script also runs with `set -x`, so the log is a complete record.
exec > >(tee "$SCRIPT_DIR/install.log") 2>&1
export PS4='+ [$(date "+%H:%M:%S")] '
set -x

echo "Setting up Ubuntu..."

echo "Checking for SSH"
if [ ! -d "$HOME/.ssh" ]; then
    echo "SSH was not found - EXIT SCRIPT!"
    exit 1
fi

echo "Setting right permissions for SSH"
chmod -v 700 "$HOME/.ssh"
# Private keys 600, public keys 644 - covers any id_* naming.
find "$HOME/.ssh" -type f ! -name '*.pub' -exec chmod 600 {} \;
find "$HOME/.ssh" -type f -name '*.pub' -exec chmod 644 {} \;

# Check for Bash-It and install if not present
if [ ! -d "$HOME/.bash_it" ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git "$HOME/.bash_it"
    "$HOME/.bash_it/install.sh" --silent
fi

# Install apt binaries
bash "$SCRIPT_DIR/scripts/setup_apt-get.bash"

# Install Google Chrome (.deb, not an apt-repo package)
bash "$SCRIPT_DIR/scripts/setup_chrome.bash"

# Install Docker (external apt repo)
bash "$SCRIPT_DIR/scripts/setup_docker.bash"

# Install 1Password CLI (external apt repo; used by backup-1password.sh)
bash "$SCRIPT_DIR/scripts/setup_1password-cli.bash"

# Install Claude Code (native installer)
bash "$SCRIPT_DIR/scripts/setup_claude.bash"

# Install snap
bash "$SCRIPT_DIR/scripts/setup_snap.bash"

# Install JetBrains Toolbox (used to install IntelliJ IDEA)
bash "$SCRIPT_DIR/scripts/setup_jetbrains-toolbox.bash"

# Enable stuff in bash-it
bash "$SCRIPT_DIR/scripts/setup_bash-it.bash"

# Install sdkman stuff
bash "$SCRIPT_DIR/scripts/setup_sdkman.bash"

# Install git-open
bash "$SCRIPT_DIR/scripts/setup_git-open.bash"

# Add custom keybindings
bash "$SCRIPT_DIR/scripts/setup_os_customization.bash"

# Install scripts
bash "$SCRIPT_DIR/scripts/setup_scripts.bash"

echo "Done! You may want to reboot."
