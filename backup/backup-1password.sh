#!/usr/bin/env bash

set -euo pipefail

# Runs the local backup (which builds the self-extracting restore-secrets.run)
# and uploads that file to 1Password as a Document item. Requires the `op` CLI
# installed and signed in (see README.md).

OP_ITEM="dotfiles-restore"
OP_VAULT="Personal"

SELF_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
RUN="$SELF_DIR/restore-secrets.run"

# 1) make the local backup (produces restore-secrets.run)
"$SELF_DIR/backup.sh"

# 2) upload to 1Password (idempotent: edit if it exists, else create)
if ! command -v op >/dev/null 2>&1; then
    echo "op CLI not found - install it (scripts/setup_1password-cli.bash) and sign in first." >&2
    exit 1
fi

if op item get "$OP_ITEM" --vault "$OP_VAULT" >/dev/null 2>&1; then
    op document edit "$OP_ITEM" --vault "$OP_VAULT" "$RUN" >/dev/null
    echo "Updated 1Password document '$OP_ITEM' in vault '$OP_VAULT'."
else
    op document create "$RUN" --title "$OP_ITEM" --vault "$OP_VAULT" >/dev/null
    echo "Created 1Password document '$OP_ITEM' in vault '$OP_VAULT'."
fi
