# Backup & restore — recovery kit

Self-contained kit for backing up and restoring the machine-specific
secrets/config that are **not** in git. Everything travels together: the two
scripts, this README, and the archive.

## What's backed up

| Item | Path |
|---|---|
| SSH keys | `~/.ssh` (all keys) |
| Gradle (personal) | `~/.gradle/gradle.properties` |
| Git config | `~/.gitconfig*` |
| Hosts file | `/etc/hosts` |

Everything ends up in `restore-secrets.tar.gz` next to the scripts. That file is
gitignored and **must never be committed** — it contains private SSH keys in
clear text.

## Make a backup

```bash
./backup.sh
```

Then move the **whole `backup/` folder** (including `restore-secrets.tar.gz`) to
a trusted medium (e.g. an encrypted USB drive) and delete the local copy when
done.

> ⚠️ **Security:** the archive holds private SSH keys unencrypted. Keep the
> medium safe and don't leave stray copies lying around.

## Fresh machine — full bootstrap

The archive is self-contained, so there is no chicken-and-egg with cloning the
dotfiles repo:

1. Copy the whole `backup/` folder (incl. `restore-secrets.tar.gz`) onto the machine.
2. Install git:
   ```bash
   sudo apt install -y git
   ```
3. Restore secrets/config (sets SSH permissions 700/600 automatically):
   ```bash
   ./restore.sh
   ```
4. Clone the dotfiles repo over SSH (keys are now in place):
   ```bash
   git clone git@github.com:brianjohnsen/dotfiles.git ~/.dotfiles
   ```
5. Run the installer:
   ```bash
   cd ~/.dotfiles && ./install.sh
   ```

## Post-install (manual)

A few things `install.sh` intentionally does not automate:

- **IntelliJ IDEA** — launch JetBrains Toolbox
  (`~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox`), sign in, and
  install IntelliJ IDEA Ultimate from there.
- **Docker without sudo** — log out/in (or run `newgrp docker`) after install so
  the `docker` group membership takes effect.
- **SDKMAN / Java** — verify with `sdk current java`; change with
  `sdk default java <version>` if needed.

## Ongoing backups

Run `backup` (alias for `backup/backup.sh`), move the folder to your trusted
medium, and delete the local copy.
