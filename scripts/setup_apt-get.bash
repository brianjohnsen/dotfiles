#!/usr/bin/env bash

set -euxo pipefail

echo "Installing software"

echo "Updating and upgrading apt"
sudo apt -y update
sudo apt -y upgrade


#echo "Adding Dell repos"
#sudo add-apt-repository -y 'deb http://dell.archive.canonical.com/updates focal-dell public'
# see: https://medium.com/@nrogap/dell-repository-for-install-additional-drivers-on-ubuntu-4cf061640180

echo "Installing..."

# latest cURL
sudo apt update
sudo apt install -y curl

sudo apt install -y fwupd

# Note: Google Chrome (.deb) and Docker (external repo) are not plain apt
# packages - they are installed by scripts/setup_chrome.bash and
# scripts/setup_docker.bash respectively.

sudo apt install -y httpie

sudo apt install -y zoxide

# make is used by git_open
sudo apt install -y make

sudo apt install -y p7zip-full

sudo add-apt-repository -y ppa:hluk/copyq
sudo apt update
sudo apt install -y copyq

sudo apt install -y xclip

sudo apt install -y expect

sudo apt install -y solaar

sudo apt install -y tree

# Static analysis (shellcheck) for the shell scripts in this repo
sudo apt install -y shellcheck

# Pulseaudio
sudo apt install -y pavucontrol

sudo apt install -y ubuntu-restricted-extras

# libfuse2 is required by the JetBrains Toolbox AppImage on Ubuntu 22.04
sudo apt install -y libfuse2

sudo add-apt-repository -y universe
sudo apt update
sudo apt install -y libgconf2-4 libnss3-1d libxss1

sudo apt install -y wkhtmltopdf

# http://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html
sudo apt install -y xdotool

# Power management
## See: https://www.tecmint.com/tlp-increase-and-optimize-linux-battery-life/
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt update
sudo apt install -y tlp tlp-rdw
sudo tlp start

sudo apt install -y dconf-editor

sudo add-apt-repository -y ppa:unit193/encryption
sudo apt update
sudo apt install -y veracrypt

#sudo apt install -y ranger
sudo apt install -y caffeine

# https://extensions.gnome.org/
sudo apt install -y chrome-gnome-shell
sudo apt install -y gnome-tweaks

# Install: http://tldr.sh/
sudo apt install -y tldr



echo "Done installing!"
