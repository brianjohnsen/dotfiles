# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Ubuntu dotfiles for Brian Johnsen. The repo sets up a full development environment (bash-it, SDKMAN, Grails/Gradle toolchain, Docker, JetBrains Toolbox, GNOME keybindings) on a fresh Ubuntu install. Scripts are tailored for Brian's work at Befri/Gennemtænkt.

## Installation

```bash
git clone git@github.com:brianjohnsen/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` runs each setup script as a subprocess (with `set -euo pipefail`), sequentially: apt packages → Chrome → Docker → 1Password CLI → 1Password browser integration → Claude Code → snap packages → default apps → JetBrains Toolbox → bash-it → SDKMAN → git-open → GNOME keybindings → script links. All output is tee'd to `install.log`.

## Commit messages

Ultra short and in English: one imperative line, no body. `Generate the VPN MFA
code locally`, not a paragraph explaining why. A body only when the change is
large enough that the diff genuinely can't be read without one (see the install
overhaul and the backup kit). Brian runs `git commit` himself — the message is
handed to him, not committed.

## Architecture: two layers

**1. bash-it customization** (`bash-it-custom/`)  
Three files are symlinked into `~/.bash_it/` by `scripts/setup_bash-it.bash`:
- `aliases/custom.aliases.bash` → `~/.bash_it/aliases/custom.aliases.bash`
- `lib/custom.bash` → `~/.bash_it/lib/custom.bash`
- `themes/brian/brian.theme.bash` → `~/.bash_it/custom/themes/brian/brian.theme.bash`

Shell functions live in `lib/custom.bash`; aliases in `aliases/custom.aliases.bash`. Both are sourced automatically by bash-it on every shell start.

**2. Utility scripts** (`bin/`, `local-bin/`)  
Scripts in `bin/` are invoked by GNOME custom keybindings (configured in `scripts/setup_os_customization.bash`). Most rely on `xdotool` to automate X11 window interactions. `local-bin/update_firmware.sh` is symlinked to `/usr/local/bin/updatefirmware` by `scripts/setup_scripts.bash`, which also symlinks everything in `local-bin/ufst/` into `~/.local/bin/`.

## Key scripts

| Script | Keybinding | Purpose |
|---|---|---|
| `bin/execute-last-shell-cmd.sh` | Ctrl+Alt+X | Re-runs last terminal command via xdotool |
| `bin/reload-chrome.sh` | Ctrl+Alt+R | Sends Ctrl+R to Chrome window |
| `bin/open-jira-task-in-firefox.sh` | Ctrl+Shift+Alt+J | Opens clipboard content as JIRA task at `gennemtaenkt.atlassian.net` |
| `bin/open-selection-in-chrome.sh` | Ctrl+Shift+Alt+G | Google-searches clipboard in Chrome |
| `local-bin/update_firmware.sh` | — | Interactive fwupdmgr wrapper |
| `local-bin/checkbackup.sh` | — | Groovy script validating KORTX/FORMUE backup files |
| `local-bin/better_history.sh` | — | One-time setup: writes history config to `/etc/bash.bashrc` |
| `local-bin/ufst/ufst-vpn` | — | UFST VPN toggle (`op`/`ned`/`status`, `--apps`); `ufst-op` and `ufst-ned` are thin wrappers |
| `local-bin/ufst/ufst-ca` | — | Syncs SKAT's internal CAs into both the system and Citrix trust stores |
| `local-bin/ufst/ufst-citrix` | — | Launches published Citrix apps by name, no `.ica` files |
| `local-bin/ufst/ufst-totp` | — | Prints the current MFA code from the TOTP seed |

## Gradle workflow

`gradlewFromParents()` in `lib/custom.bash` walks up parent directories to find the nearest `gradlew`. Gradle aliases (`gw`, `gwb`, `gwct`, etc.) all call this function, so they work from any subdirectory of a Gradle project.

## Adding new aliases or functions

- Shell aliases → `bash-it-custom/aliases/custom.aliases.bash`
- Shell functions → `bash-it-custom/lib/custom.bash`
- New standalone scripts → `bin/` (add a matching keybinding in `scripts/setup_os_customization.bash` if needed)

Changes to `aliases/custom.aliases.bash` or `lib/custom.bash` take effect in new shell sessions (or `source ~/.bashrc`). No re-running of `install.sh` needed — the symlinks are already in place.

## UFST tooling (`local-bin/ufst/`)

Scripts for Brian's work at UFST/SKAT, symlinked into `~/.local/bin/` (already on PATH via `.bashrc`).

**The password is not in this repo.** `ufst-vpn` sources `~/.ufst-password` (mode 600), which sets `VPN_PASSWORD` and `VPN_TOTP_SECRET`. Override the location with `$UFST_PASSWORD_FILE`. The file lives in `$HOME` rather than here so that no `git add -f`, IDE "add all", or repo-wide archiving can ever pick it up; `.gitignore` carries a matching rule purely as a second line of defence. Missing file → the script prints exactly what to create and exits.

`VPN_TOTP_SECRET` holds the base32 seed from a "different authenticator app" registration in Entra (mysignins.microsoft.com → Add sign-in method), added alongside the existing Microsoft Authenticator registration rather than replacing it. With it set, `ufst-op` connects with no prompts at all.

Store the seed exactly as Microsoft displays it; `ufst-vpn` prepends the `base32:` prefix that openconnect requires. Without that prefix openconnect reads the string as raw bytes and generates wrong codes with no error — just a login that gets rejected.

`ufst-totp` prints the current code from the same seed. It exists to confirm the seed during enrolment, and as a fallback for typing the code by hand if openconnect ever fails to recognise the ASA's second form field as a token field.

`--apps` on `ufst-op`/`ufst-ned` starts and closes the Teams and Outlook PWAs
alongside the tunnel. It is opt-in: without the flag neither command touches a
window. The `opufstapps`/`nedufstapps` aliases are the everyday form that passes
`--apps`, and `wifijohnsen` runs `ufst-ned --apps` after switching to the home
network. The app-ids live in the `UFST_APPS` array in `ufst-vpn`.
`ned --apps` also closes open Citrix sessions — those are real processes (one
`wfica` each), so a plain `pkill` on `wfica` is fine there.

The handling is window-based, not process-based, and has to be: Chrome runs no
process per PWA — `google-chrome --app-id=…` hands the launch to the running
browser and exits — so `pkill` would take all of Chrome with it. Each PWA window
carries `WM_CLASS=crx_<app-id>` (the `StartupWMClass` of its
`~/.local/share/applications/chrome-<app-id>-Default.desktop`), which `xdotool`
can target. This is X11-only, like everything else in `bin/`.

Closing has to use Chrome's own close shortcut (activate the window, send
`ctrl+shift+w`), not `xdotool windowclose`. On the `WM_DELETE_WINDOW` that
windowclose sends, Chrome drops the window but leaves the app in a state where
the next `--app-id` launch is silently swallowed: rc=0, "Åbner i eksisterende
browsersession", no window, and Teams stays unopenable until Chrome itself is
restarted. Verified both ways, several rounds, both apps.

The cost is focus. `xdotool key` goes through XTEST to whatever holds input focus
at that instant, and `windowactivate --sync` only waits for the WM's
`_NET_ACTIVE_WINDOW` — Chrome takes keyboard focus a moment later. So
`luk_vindue` *confirms* `getwindowfocus` matches the target before firing and
skips the window otherwise: a stray ctrl+shift+w in another Chrome window would
close that window and all its tabs. Even with focus confirmed the key is
occasionally not turned into a close (both apps, usually right after opening),
hence three attempts before reporting failure — and it reports honestly, rather
than printing "lukker" for a window that is still there. `luk_apps` saves and
restores the originally active window, the same dance as `bin/reload-chrome.sh`.

So if a PWA won't open and `gtk-launch` exits 0 with no window, the install is
almost certainly fine: something closed it with `WM_DELETE_WINDOW`.
`pkill -TERM -x chrome` (clean shutdown, session restored on next start) clears
it. Closing all windows is *not* enough — Chrome keeps running with no windows
("Continue running background apps"), so the browser process survives.

`ufst-ca` must be re-run whenever SKAT rotates their issuing CAs; the symptom is a sudden certificate error on internal sites *or* Citrix failing to reach StoreFront. It keeps `/usr/local/share/ca-certificates/` and Citrix's own `/opt/Citrix/ICAClient/keystore/cacerts/` in sync, since Citrix does not consult the system store.

## Backup & restore

`backup/` is a self-contained recovery kit (not run by `install.sh`):
- `backup/backup.sh` (alias `backup`) archives `~/.ssh`, `~/.gnupg`, `~/.kube`, `~/.config/{doctl,copyq,monitors.xml,autostart}`, `~/.docker/config.json`, personal Gradle config, `~/.gitconfig*` and `/etc/hosts` into a single self-extracting `backup/restore-secrets.run` (gitignored — private keys/tokens in clear text). Restore = get that one file onto the machine and `bash restore-secrets.run`.
- `backup/backup-1password.sh` (alias `backup1p`) runs `backup.sh` and uploads the `.run` to 1Password (document `dotfiles-restore`, vault `Personal`) via the `op` CLI.
- `backup/restore.sh` is the runner's header (catted into the `.run`) and also the restore logic; it fixes SSH/GPG permissions. Dual-mode: embedded in a `.run` (after a `__PAYLOAD_BELOW__` marker) it self-extracts; run standalone next to a `restore-secrets.tar.gz` it reads that instead.
- `backup/README.md` is the full fresh-install bootstrap runbook.

## Environment variables

- `$GRAILS_OPTS` — exported by `lib/custom.bash` (`-Xmx4G -Xms512m …`); the `fp` alias overrides it for Formueportalen.

## Notes

- IntelliJ IDEA is installed manually via JetBrains Toolbox (see `backup/README.md`), not as a snap.
- `mailto:` is deliberately left with no handler — clicking a mail link does nothing. Routing it to Gmail in Chrome was tried and rejected: with several Google accounts open in different tabs, Chrome picks the wrong one. Leaving `mailto` merely *unset* doesn't work, because once Thunderbird is purged the Firefox snap is the only app advertising `x-scheme-handler/mailto` and the fallback picks it. So `scripts/setup_default-apps.bash` blocks it via `[Removed Associations]` in `~/.config/mimeapps.list`. The Firefox snap itself stays installed on purpose — `bin/open-jira-task-in-firefox.sh` uses it.
- The 1Password extension in Firefox only connects to the desktop app because `scripts/setup_1password.bash` adds `xdg-desktop-portal` to `/etc/1password/custom_allowed_browsers`. The Firefox snap can't exec `/opt/1Password/1Password-BrowserSupport` itself, so it goes through the WebExtensions portal; 1Password then sees the portal as the calling process and rejects it as `UnknownBrowser` (visible in `~/.config/1Password/logs/BrowserSupport/`). Chrome needs none of this — it's a real .deb and launches the helper directly. Replacing the Firefox snap with Mozilla's .deb (what 1Password officially recommends) was rejected as too invasive: apt repo + pinning, a 1.7 GB profile migration out of `~/snap/firefox/common/.mozilla`, and the mailto desktop-id above would change.
