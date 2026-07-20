#!/usr/bin/env bash

set -euo pipefail

# Restores the archive produced by backup.sh (expected next to this script).
# Safe to run repeatedly - it overwrites existing files.

ARCHIVE_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
ARCHIVE="$ARCHIVE_DIR/restore-secrets.tar.gz"

if [ ! -f "$ARCHIVE" ]; then
    echo "Archive not found: $ARCHIVE" >&2
    echo "Copy the backup/ folder (including restore-secrets.tar.gz) here first." >&2
    exit 1
fi

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT
tar -xzf "$ARCHIVE" -C "$STAGING"

# Restore home files (.ssh, .gradle, .gitconfig*)
if [ -d "$STAGING/home" ]; then
    cp -a "$STAGING/home/." "$HOME/"
fi

# Fix SSH permissions
if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    find "$HOME/.ssh" -type f ! -name '*.pub' -exec chmod 600 {} \;
    find "$HOME/.ssh" -type f -name '*.pub' -exec chmod 644 {} \;
fi

# Restore /etc/hosts
if [ -f "$STAGING/etc/hosts" ]; then
    sudo cp "$STAGING/etc/hosts" /etc/hosts
fi

echo "Restore complete."
