#!/usr/bin/env bash

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

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

sudo apt install -y httpie

sudo apt install -y fasd

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

sudo apt install -y bat

## install on 20.10+: https://the.exa.website/docs
#sudo apt install -y exa

# Pulseaudio
sudo apt install -y pavucontrol

sudo apt install -y ubuntu-restricted-extras

# to mount ERST logs dir
sudo apt install -y cifs-utils


#https://www.linuxbabe.com/ubuntu/install-dropbox-ubuntu-20-04
#sudo apt install -y nautilus-dropbox

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

# Database
#sudo apt install -y postgresql-client-common
#sudo apt install -y postgresql-client8


# Cisco VPN
sudo apt install -y network-manager-openconnect-gnome network-manager-openconnect openconnect vpnc openvpn vpnc-scripts

# removes package to fix sporadic anyconnect disconnects: https://community.cisco.com/t5/vpn/extremely-frustrating-cisco-anyconnect-on-ubuntu-keeps-dropping/m-p/4156880/highlight/true#M274644
sudo apt remove network-manager-config-connectivity-ubuntu

########################################################################################################################
## Apps that (might) need atttention
########################################################################################################################

# Docker
## See: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt -y update
apt-cache policy docker-ce
sudo apt install -y docker-ce
#sudo systemctl status docker


## VirtualBox (required by vagrant)
#sudo apt install -y virtualbox virtualbox-ext-pack
## Vagrant
#sudo apt install -y vagrant

## Ansible (vault used by helm charts)
#sudo apt install -y ansible

# Install: http://tldr.sh/
sudo apt install -y tldr

# MySQL
## See: https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-22-04
## Also: https://stackoverflow.com/a/52335791
#if [[ -f ! /etc/init.d/mysql* ]]; then
#    sudo apt install -y mysql-server
#    # only run init script first time
#    sudo mysql_secure_installation
#fi


echo "Done installing!"
