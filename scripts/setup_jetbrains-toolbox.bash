#!/usr/bin/env bash

set -euxo pipefail

# JetBrains Toolbox - used to install/manage IntelliJ IDEA (replaces the old
# intellij-idea-ultimate snap). There is no official apt/snap package, so we
# download the latest tarball. Requires libfuse2 (installed by setup_apt-get).

TOOLBOX_BIN="$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"

if [ -x "$TOOLBOX_BIN" ]; then
    echo "JetBrains Toolbox already installed"
    exit 0
fi

echo "Installing JetBrains Toolbox..."

URL="$(curl -fsSL 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' \
    | grep -Po '"linux":.*?"link":"\K[^"]+')"

if [ -z "$URL" ]; then
    echo "Could not determine JetBrains Toolbox download URL" >&2
    exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP/jetbrains-toolbox.tar.gz"
mkdir -p "$(dirname "$TOOLBOX_BIN")"
tar -xzf "$TMP/jetbrains-toolbox.tar.gz" -C "$TMP"
mv "$TMP"/jetbrains-toolbox-*/jetbrains-toolbox "$TOOLBOX_BIN"

echo "JetBrains Toolbox installed at $TOOLBOX_BIN"
echo "Launch it once to sign in and install IntelliJ IDEA Ultimate."
