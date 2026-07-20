#!/usr/bin/env bash

set -euo pipefail

# Backs up the machine-specific secrets/config that are NOT in git, into a
# single local archive next to this script. Move the whole backup/ folder to a
# trusted medium afterwards. See README.md.

ARCHIVE_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
ARCHIVE="$ARCHIVE_DIR/restore-secrets.tar.gz"

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT
mkdir -p "$STAGING/home/.gradle" "$STAGING/etc"

# SSH keys
if [ -d "$HOME/.ssh" ]; then
    cp -a "$HOME/.ssh" "$STAGING/home/"
fi

# Gradle - only gradle.properties (not work publishing config, not init.gradle)
[ -f "$HOME/.gradle/gradle.properties" ] && cp -a "$HOME/.gradle/gradle.properties" "$STAGING/home/.gradle/"

# Git config
for f in "$HOME"/.gitconfig*; do
    [ -e "$f" ] && cp -a "$f" "$STAGING/home/"
done

# /etc/hosts
sudo cp /etc/hosts "$STAGING/etc/hosts"

tar -czf "$ARCHIVE" -C "$STAGING" .

echo "Backup written to: $ARCHIVE"
echo
echo "NOTE: the archive contains private SSH keys in clear text."
echo "Move the whole backup/ folder to a trusted medium and delete local copies when done."
