#!/usr/bin/env bash

echo "Installing software"

echo "Updating and upgrading apt-get"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Removing outdated..."
# Installing newer version via snap
sudo apt remove -y fwupd
echo "Done removing!"


echo "Installing..."

# latest cURL
sudo apt-get update
sudo apt-get install -y curl

# Chrome
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo apt-get update
#sudo apt-get install -y google-chrome-stable

sudo apt install -y httpie

sudo apt-get install -y fasd

sudo apt install p7zip-full

sudo add-apt-repository -y ppa:hluk/copyq
sudo apt-get update
sudo apt install -y copyq

sudo apt install -y xclip

sudo apt install -y expect

sudo apt install -y solaar

sudo apt install -y nautilus-dropbox

sudo add-apt-repository -y universe
sudo apt-get update
sudo apt-get install -y libgconf2-4 libnss3-1d libxss1

sudo apt-get install -y wkhtmltopdf

# http://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html
sudo apt install -y xdotool

# Power management
## See: https://www.tecmint.com/tlp-increase-and-optimize-linux-battery-life/
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt install -y tlp tlp-rdw
sudo tlp start

sudo apt install -y dconf-editor

sudo add-apt-repository -y ppa:unit193/encryption
sudo apt update
sudo apt install -y veracrypt

sudo apt install -y ranger
sudo apt install -y caffeine

# https://extensions.gnome.org/
sudo apt-get install -y chrome-gnome-shell

# AS LONG AS I'M ON UNITY!
sudo apt-get install -y unity-tweak-tool

# Node and NPM
## See: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04
sudo apt install -y nodejs
sudo apt install -y npm


# Database
sudo apt install -y postgresql-client-common
sudo apt install -y postgresql-client8

sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo apt-get update
sudo apt-get install -y dbeaver-ce


# Cisco VPN
sudo apt install -y network-manager-openconnect-gnome network-manager-openconnect openconnect vpnc openvpn vpnc-scripts

########################################################################################################################
## Apps that (might) need atttention
########################################################################################################################

# Docker
## See: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
## and: https://docs.docker.com/install/linux/docker-ce/ubuntu/#upgrade-docker-after-using-the-convenience-script
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

## VirtualBox (required by vagrant)
#sudo apt install -y virtualbox virtualbox-ext-pack
## Vagrant
#sudo apt install -y vagrant

## Ansible (vault used by helm charts)
sudo apt install -y ansible


# MySQL
## See: https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04
if [ -f ! /etc/init.d/mysql* ]; then
    sudo apt-get install -y mysql-server
    # only run init script first time
    sudo mysql_secure_installation
fi


echo "Done installing!"
