#!/usr/bin/env bash

set -exo pipefail

echo "Installing sdkman..."

# Install SDKMAN if not present
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
fi

echo "Setting up sdkman..."

# Load the `sdk` function into this shell. Without this the sdk commands below
# fail with "command not found" (the reason this script used to be broken).
# No `-u`: sdkman-init.sh / the `sdk` function reference unset vars by design.
# Trace off around the source - sdkman-init would flood install.log.
set +x
# shellcheck source=/dev/null
source "$HOME/.sdkman/bin/sdkman-init.sh"
set -x

# Java - latest stable (no version pinning)
yes | sdk install java

# Other tools
yes | sdk install grails
yes | sdk install groovy
yes | sdk install gradle
