#!/usr/bin/env bash

set -euxo pipefail

echo "Configuring 1Password browser integration..."

# Let the 1Password app talk to the Firefox snap.
#
# Firefox on Ubuntu is a snap, and a confined snap cannot exec a host binary, so
# it goes through org.freedesktop.portal.WebExtensions instead: the portal starts
# /opt/1Password/1Password-BrowserSupport on the host side on Firefox's behalf.
# 1Password-BrowserSupport then verifies the browser by looking at its parent
# process - and sees the portal, not Firefox:
#
#   Verifying browser "/usr/libexec/xdg-desktop-portal"
#   Browser support error: UnknownBrowser(/usr/libexec/xdg-desktop-portal)
#
# which surfaces in the extension as "Integration status: Connection problem".
# Chrome is unaffected: it is a real .deb and launches the helper directly.
#
# Allowlisting the portal is 1Password's own escape hatch for this. The trade-off
# is that 1Password can no longer tell which app asked for the native messaging
# channel - any app that can reach the WebExtensions portal could ask for one.
# The portal's permission store (~/.local/share/flatpak/db/webextensions) and its
# "Allow ... to start WebExtension backend?" prompt are the remaining gate.
#
# The alternative - replacing the Firefox snap with Mozilla's .deb, which is what
# 1Password officially recommends - was rejected: it needs an apt repo plus
# pinning, a profile migration out of ~/snap/firefox/common/.mozilla, and a change
# to the mailto blocking in setup_default-apps.bash. Firefox is only the secondary
# browser here; Chrome is the default.

ALLOWLIST=/etc/1password/custom_allowed_browsers

# The file is world-readable, so the check itself needs no sudo - a re-run that
# has nothing to do stays quiet instead of asking for a password.
if ! grep -qxF 'xdg-desktop-portal' "$ALLOWLIST" 2>/dev/null; then
    # The 1Password .deb creates this directory, but the app is installed by hand
    # (see backup/README.md), so don't assume it exists yet. The file is read at
    # runtime, so writing it before the app is installed is fine.
    sudo mkdir -p "$(dirname "$ALLOWLIST")"

    # The file 1Password ships ends without a newline, so appending straight to
    # it would glue the entry onto the trailing '#' and comment it out.
    if [ -s "$ALLOWLIST" ] && [ "$(tail -c1 "$ALLOWLIST" | wc -l)" -eq 0 ]; then
        printf '\n' | sudo tee -a "$ALLOWLIST" >/dev/null
    fi

    echo 'xdg-desktop-portal' | sudo tee -a "$ALLOWLIST"
fi

# Nothing to restart: the portal spawns a fresh 1Password-BrowserSupport for
# every attempt, and it reads the allowlist on startup, so the extension picks
# this up on its next connection attempt by itself.
echo "Done configuring 1Password browser integration"
