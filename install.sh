#!/usr/bin/env bash


echo "Setting up Ubuntu..."


echo "Checking for SSH"
if [ ! -d $HOME/.ssh/ ]; then
    echo "SSH was not found - EXIT SCRIPT!"
    exit
fi

echo "Setting right permissions for SSH"
chmod -v 700 ~/.ssh
chmod -v 600 ~/.ssh/id_rsa


# Check for Bash-It and install if not present
if [ ! $BASH_IT ]; then
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh --silent
fi


# Install apt binaries
source scripts/setup_apt-get.bash

# Install snap
source scripts/setup_snap.bash

# Enable stuff in bash-it
source scripts/setup_bash-it.bash

# Install sdkman stuff
source scripts/setup_sdkman.bash

# Install git-open
source scripts/setup_git-open.bash

# Add custom keybindings
source scripts/setup_os_customization.bash

# Install non apt binaries (LASTPASS)
source scripts/setup_other_apps.bash

## Fix acpi-osi
#source scripts/fix-acpi-osi.bash

## Run Dell XPS custom stuff
#source scripts/setup_dell_xps.bash

##########################################################################################
## Backup:
# https://www.ostechnix.com/systemback-restore-ubuntu-desktop-and-server-to-previous-state/
##########################################################################################


#### DO THIS
# shutdown -r now
####