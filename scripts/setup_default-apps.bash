#!/usr/bin/env bash

set -euxo pipefail

echo "Setting up default applications..."

# Thunderbird is preinstalled on a fresh Ubuntu and is the registered mailto
# handler. Purge it - we don't want a mail client, and while it is installed it
# owns every mail link on the machine.
#
# Guard on dpkg-query: `apt purge 'thunderbird*'` exits 100 when nothing matches,
# which `set -e` would turn into a failed install.
if dpkg-query -W -f='${Status}\n' 'thunderbird*' 2>/dev/null | grep -q .; then
    sudo apt purge -y 'thunderbird*'
fi

# On Ubuntu 24.04+ Thunderbird ships as a snap instead of a .deb.
if snap list thunderbird >/dev/null 2>&1; then
    sudo snap remove --purge thunderbird
fi

echo "Making Chrome the default for all browser types..."

BROWSER_TYPES=(
    text/html
    x-scheme-handler/http
    x-scheme-handler/https
    x-scheme-handler/about
    x-scheme-handler/unknown
)

for type in "${BROWSER_TYPES[@]}"; do
    xdg-mime default google-chrome.desktop "$type"
done

xdg-settings set default-web-browser google-chrome.desktop

echo "Leaving mailto: without a handler..."

# mailto: is deliberately left with no handler at all - clicking a mail link
# should do nothing. Routing it to Gmail in Chrome was tried and rejected: with
# several Google accounts open in different tabs, Chrome opens the compose window
# in whichever account it feels like.
#
# Just leaving mailto unset is not enough. Once Thunderbird is gone, the Firefox
# snap is the only app advertising x-scheme-handler/mailto, so the fallback picks
# it and mail links open in Firefox. Blocking that association is what actually
# makes mailto empty.
#
# There is no xdg-mime equivalent for [Removed Associations], hence the
# section-aware edit below.
python3 - <<'PY'
import os

path = os.path.expanduser("~/.config/mimeapps.list")
key, val = "x-scheme-handler/mailto", "firefox_firefox.desktop;"
lines = open(path).read().splitlines() if os.path.exists(path) else []

# Drop any mailto default left over from earlier runs of this script.
kept, section = [], None
for line in lines:
    if line.startswith("["):
        section = line.strip()
    if section in ("[Default Applications]", "[Added Associations]") \
            and line.startswith(key + "="):
        continue
    kept.append(line)
lines = kept

try:
    start = lines.index("[Removed Associations]")
except ValueError:
    if lines and lines[-1].strip():
        lines.append("")
    lines += ["[Removed Associations]", f"{key}={val}"]
else:
    end = next((i for i in range(start + 1, len(lines))
                if lines[i].startswith("[")), len(lines))
    if not any(l.startswith(key + "=") for l in lines[start + 1:end]):
        lines.insert(end, f"{key}={val}")

open(path, "w").write("\n".join(lines) + "\n")
PY

# Remove the Chrome mailto policy written by earlier versions of this script.
for stale in /etc/opt/chrome/policies/managed/mailto-gmail.json \
             /etc/opt/chrome/policies/recommended/mailto-gmail.json; do
    if [ -e "$stale" ]; then
        sudo rm -f "$stale"
    fi
done

# Echo back what we ended up with, so install.log is a complete record.
for type in "${BROWSER_TYPES[@]}"; do
    echo "$type -> $(xdg-mime query default "$type")"
done
gio mime x-scheme-handler/mailto

echo "Done setting up default applications"
