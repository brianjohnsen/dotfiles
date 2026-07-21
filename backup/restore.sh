#!/usr/bin/env bash

set -euo pipefail

# Restores the machine-specific secrets/config. Safe to run repeatedly.
#
# Dual-mode:
#   * Normal   - reads the sibling restore-secrets.tar.gz (run from backup/ folder).
#   * Embedded - if this file has a __PAYLOAD_BELOW__ marker with an archive
#     appended after it (a self-extracting restore-secrets.run), it reads the
#     archive from itself. Lets you download one file and just run it.

SELF="$(readlink -f "$0")"
MARKER="__PAYLOAD_BELOW__"

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT

if grep -aq "^${MARKER}\$" "$SELF"; then
    # Self-extracting: the archive starts on the line after the marker.
    line=$(grep -an "^${MARKER}\$" "$SELF" | head -1 | cut -d: -f1)
    tail -n +$((line + 1)) "$SELF" | tar -xz -C "$STAGING"
else
    ARCHIVE="$(dirname "$SELF")/restore-secrets.tar.gz"
    if [ ! -f "$ARCHIVE" ]; then
        echo "Archive not found: $ARCHIVE" >&2
        echo "Copy the backup/ folder (including restore-secrets.tar.gz) here first," >&2
        echo "or run the self-extracting restore-secrets.run instead." >&2
        exit 1
    fi
    tar -xzf "$ARCHIVE" -C "$STAGING"
fi

# Restore home files (.ssh, .gnupg, .kube, .gradle, .gitconfig*, .config/*, .docker/*)
if [ -d "$STAGING/home" ]; then
    cp -a "$STAGING/home/." "$HOME/"
fi

# Fix SSH permissions
if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    find "$HOME/.ssh" -type f ! -name '*.pub' -exec chmod 600 {} \;
    find "$HOME/.ssh" -type f -name '*.pub' -exec chmod 644 {} \;
fi

# Fix GPG permissions (gnupg refuses a world/group-accessible keyring)
if [ -d "$HOME/.gnupg" ]; then
    find "$HOME/.gnupg" -type d -exec chmod 700 {} \;
    find "$HOME/.gnupg" -type f -exec chmod 600 {} \;
fi

# Restore /etc/hosts (needs root; non-fatal so a missing sudo doesn't abort the
# whole restore after the important secrets are already in place)
if [ -f "$STAGING/etc/hosts" ]; then
    if sudo cp "$STAGING/etc/hosts" /etc/hosts; then
        echo "Restored /etc/hosts."
    else
        echo "WARNING: could not update /etc/hosts (needs root) - skipped." >&2
    fi
fi

echo "Restore complete."

# Stop here: when this file is a self-extracting restore-secrets.run, everything
# below is the __PAYLOAD_BELOW__ marker + the embedded archive. Must not execute.
exit 0
