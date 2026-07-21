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

`install.sh` runs each setup script as a subprocess (with `set -euo pipefail`), sequentially: apt packages → Chrome → Docker → 1Password CLI → snap packages → JetBrains Toolbox → bash-it → SDKMAN → git-open → GNOME keybindings → script links. All output is tee'd to `install.log`.

## Architecture: two layers

**1. bash-it customization** (`bash-it-custom/`)  
Three files are symlinked into `~/.bash_it/` by `scripts/setup_bash-it.bash`:
- `aliases/custom.aliases.bash` → `~/.bash_it/aliases/custom.aliases.bash`
- `lib/custom.bash` → `~/.bash_it/lib/custom.bash`
- `themes/brian/brian.theme.bash` → `~/.bash_it/custom/themes/brian/brian.theme.bash`

Shell functions live in `lib/custom.bash`; aliases in `aliases/custom.aliases.bash`. Both are sourced automatically by bash-it on every shell start.

**2. Utility scripts** (`bin/`, `local-bin/`)  
Scripts in `bin/` are invoked by GNOME custom keybindings (configured in `scripts/setup_os_customization.bash`). Most rely on `xdotool` to automate X11 window interactions. `local-bin/update_firmware.sh` is symlinked to `/usr/local/bin/updatefirmware` by `scripts/setup_scripts.bash`.

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

## Gradle workflow

`gradlewFromParents()` in `lib/custom.bash` walks up parent directories to find the nearest `gradlew`. Gradle aliases (`gw`, `gwb`, `gwct`, etc.) all call this function, so they work from any subdirectory of a Gradle project.

## Adding new aliases or functions

- Shell aliases → `bash-it-custom/aliases/custom.aliases.bash`
- Shell functions → `bash-it-custom/lib/custom.bash`
- New standalone scripts → `bin/` (add a matching keybinding in `scripts/setup_os_customization.bash` if needed)

Changes to `aliases/custom.aliases.bash` or `lib/custom.bash` take effect in new shell sessions (or `source ~/.bashrc`). No re-running of `install.sh` needed — the symlinks are already in place.

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
