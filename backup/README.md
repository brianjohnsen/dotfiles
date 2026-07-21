# Backup & restore — recovery kit

Backs up the machine-specific secrets/config that are **not** in git, and restores
them on a fresh machine (before cloning the repo).

## What's backed up

| Item | Path |
|---|---|
| SSH keys | `~/.ssh` (all keys + config) |
| GPG keys | `~/.gnupg` |
| Kubernetes | `~/.kube` |
| DigitalOcean CLI | `~/.config/doctl` |
| Docker auth | `~/.docker/config.json` |
| Gradle (personal) | `~/.gradle/gradle.properties` |
| Git config | `~/.gitconfig*` |
| CopyQ / display / autostart | `~/.config/copyq`, `~/.config/monitors.xml`, `~/.config/autostart` |
| Hosts file | `/etc/hosts` |

Backup produces a **single self-extracting file**, `restore-secrets.run`, next to
these scripts. It is **gitignored** (it contains private SSH/GPG keys and tokens
in clear text — never commit it). Restore = get that one file onto the machine and
run it. No need to copy the folder or clone the repo.

## Make a backup

**Local only:**
```bash
backup          # alias for backup/backup.sh
```
Produces `restore-secrets.run`. Copy just that one file to a trusted medium (e.g.
an encrypted USB) and delete the local copy when done.

**Local + push to 1Password (recommended):**
```bash
backup1p        # alias for backup/backup-1password.sh
```
Builds `restore-secrets.run` and uploads it to 1Password as the document
**dotfiles-restore** (vault **Personal**). Requires the `op` CLI installed and
authenticated (see below).

> ⚠️ **Security:** the runner holds private SSH/GPG keys and tokens unencrypted.
> Keep any medium safe and don't leave stray copies lying around. 1Password stores
> it encrypted in your vault.

## op CLI (one-time)

`op` is installed by `scripts/setup_1password-cli.bash` (run by `install.sh`).
Authenticate it once: in the 1Password app → **Settings → Developer → "Integrate
with 1Password CLI"**, or run `op signin`. (`op whoami` may report "not signed in"
under app integration even when it works — `op vault list` is the real test.)

## Restore on a fresh machine

Restore runs **before** cloning the repo (it provides the SSH keys you need to
clone). Get `restore-secrets.run` onto the machine — either way, then run it:

- **From 1Password:** install the 1Password app, sign in, download the
  **dotfiles-restore** document (you get `restore-secrets.run`).
- **From a medium (USB):** copy the single `restore-secrets.run` file over.

```bash
bash restore-secrets.run
```
It unpacks everything and fixes SSH/GPG permissions (needs `sudo` only for
`/etc/hosts`, which is skipped with a warning if root isn't available).

After restoring, continue the fresh-install steps in the main [README](../readme.md).
