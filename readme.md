# Brian's Dotfiles

## What Is This?

This repository serves as my way to help me setup and maintain my Ubuntu. 
It takes the effort out of installing everything manually. 
Everything which is needed to install my preferred setup is detailed in this readme. 
Feel free to explore, learn and copy parts for your own dotfiles. Enjoy!


## A Fresh Ubuntu Setup

1. Set main download server
   1. Software & updates -> Ubuntu software -> Download from: Main server
1. Restore your secrets/config. Get `restore-secrets.run` onto the machine —
   download the **dotfiles-restore** document from 1Password (install the app +
   sign in first), or copy it from a USB — then run it:
   ```bash
   bash restore-secrets.run
   ```
   This restores your SSH/GPG keys, git config, etc. (see
   [`backup/README.md`](backup/README.md) for details).
1. Install git, clone this repo, and run the installer:
   ```bash
   sudo apt install -y git
   git clone git@github.com:brianjohnsen/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles && ./install.sh
   ```
   All output (every command + result) is saved to `~/.dotfiles/install.log`.
1. Restart to finalize: `shutdown -r now`

Your Ubuntu is now ready to use!


## Post-install (manual)

A few things `install.sh` intentionally does not automate:

- **IntelliJ IDEA** — launch JetBrains Toolbox
  (`~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox`), sign in, and install
  IntelliJ IDEA Ultimate from there.
- **Docker without sudo** — log out/in (or `newgrp docker`) after install so the
  `docker` group membership takes effect.
- **SDKMAN / Java** — verify `sdk current java`; change with
  `sdk default java <version>` if needed.


## Customize

Further customizations.

1. Disable all annoying keyboard shortcuts
   1. Keyboard -> Shortcuts



## Thanks To...

Read the blog post: https://driesvints.com/blog/getting-started-with-dotfiles


## License

The MIT License. Please see [the license file](license.md) for more information.
