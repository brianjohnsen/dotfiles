#!/usr/bin/env bash

set -euo pipefail

# Backs up the machine-specific secrets/config that are NOT in git into a single
# self-extracting file: restore-secrets.run. Copy just that one file to a trusted
# medium (or use backup1p to push it to 1Password) and run it to restore. See README.md.

SELF_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
RUN="$SELF_DIR/restore-secrets.run"

STAGING="$(mktemp -d)"
TARBALL="$(mktemp --suffix=.tar.gz)"
trap 'rm -rf "$STAGING" "$TARBALL"' EXIT
mkdir -p "$STAGING/home/.gradle" "$STAGING/home/.config" "$STAGING/home/.docker" "$STAGING/etc"

# SSH keys
[ -d "$HOME/.ssh" ] && cp -a "$HOME/.ssh" "$STAGING/home/"

# GPG keys
[ -d "$HOME/.gnupg" ] && cp -a "$HOME/.gnupg" "$STAGING/home/"

# Kubernetes config
[ -d "$HOME/.kube" ] && cp -a "$HOME/.kube" "$STAGING/home/"

# Gradle - only gradle.properties (not work publishing config, not init.gradle)
[ -f "$HOME/.gradle/gradle.properties" ] && cp -a "$HOME/.gradle/gradle.properties" "$STAGING/home/.gradle/"

# Docker registry auth
[ -f "$HOME/.docker/config.json" ] && cp -a "$HOME/.docker/config.json" "$STAGING/home/.docker/"

# Selected ~/.config entries: doctl token, CopyQ, monitor layout, autostart
for c in doctl copyq monitors.xml autostart; do
    [ -e "$HOME/.config/$c" ] && cp -a "$HOME/.config/$c" "$STAGING/home/.config/"
done

# Git config (all variants: .gitconfig, .gitconfig-*)
for f in "$HOME"/.gitconfig*; do
    [ -e "$f" ] && cp -a "$f" "$STAGING/home/"
done

# /etc/hosts (world-readable, no sudo needed to read it)
cp /etc/hosts "$STAGING/etc/hosts"

# Drop non-archivable sockets (e.g. copyq's runtime .copyq_s) to avoid tar warnings
find "$STAGING" -type s -delete

tar -czf "$TARBALL" -C "$STAGING" .

# Assemble the self-extracting runner: restore.sh + marker + embedded archive.
# The tarball itself is temporary and never written next to the script.
{ cat "$SELF_DIR/restore.sh"; echo '__PAYLOAD_BELOW__'; cat "$TARBALL"; } > "$RUN"
chmod +x "$RUN"

echo "Backup written to: $RUN"
echo
echo "NOTE: the runner contains private SSH/GPG keys and tokens in clear text."
echo "Copy just this one file to a trusted medium (or run 'backup1p' to push it to"
echo "1Password), and restore with:  bash restore-secrets.run"
