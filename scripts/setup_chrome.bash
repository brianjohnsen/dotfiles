#!/usr/bin/env bash

set -euxo pipefail

echo "Installing Google Chrome..."

# Chrome is a downloaded .deb (not an apt-repo package). Download to a temp file
# and clean up so we don't litter the repo.
CHROME_DEB="$(mktemp --suffix=.deb)"
trap 'rm -f "$CHROME_DEB"' EXIT
wget -O "$CHROME_DEB" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y "$CHROME_DEB"
