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
1. Install git: `sudo apt-get update && sudo apt-get install -y git`
1. Clone this repo to `~/.dotfiles` 
   1. `git clone git@github.com:brianjohnsen/dotfiles.git ~/.dotfiles`
1. Run `install.sh` to start the installation
1. Make sure Dropbox is set up and synced
    1. Install Dropbox manually
    1. via https://linuxconfig.org/ubuntu-20-04-dropbox-installation-and-desktop-integration
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
