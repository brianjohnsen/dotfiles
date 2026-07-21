#!/usr/bin/env bash

set -euxo pipefail

# Claude Code - Anthropic's CLI. Installed via the official native installer,
# which drops versions under ~/.local/share/claude and symlinks the binary into
# ~/.local/bin/claude (already on PATH via bash-it-custom/lib/custom.bash).

if command -v claude >/dev/null 2>&1; then
    echo "Claude Code already installed"
    exit 0
fi

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash
