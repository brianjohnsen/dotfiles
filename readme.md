# Brian's Dotfiles

## What Is This?

This repository serves as my way to help me setup and maintain my Ubuntu. 
It takes the effort out of installing everything manually. 
Everything which is needed to install my preffered setup is detailed in this readme. 
Feel free to explore, learn and copy parts for your own dotfiles. Enjoy!


## A Fresh Ubuntu Setup

Follow these install instructions to setup a new Ubuntu.

1. Set main download server
   1. Software & updates -> Ubuntu software -> Download from: Main server
1. Restore your secrets/config and bootstrap the machine following
   [`backup/README.md`](backup/README.md) — it restores SSH keys, installs git,
   clones this repo to `~/.dotfiles`, and runs `install.sh`.
1. After install, install IntelliJ IDEA via **JetBrains Toolbox** (launched from
   `~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox`).
1. Restart your computer to finalize the process
   1. `shutdown -r now`

Your Ubuntu is now ready to use!


## Customize

Further customizations.

1. Disable all annoying keyboard shortcuts
   1. Keyboard -> Shortcuts



## Thanks To...

Read the blog post: https://driesvints.com/blog/getting-started-with-dotfiles


## License

The MIT License. Please see [the license file](license.md) for more information.
