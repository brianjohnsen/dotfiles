#!/usr/bin/env bash

echo "Installing software"

echo "Updating and upgrading apt-get"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing..."

# latest cURL
sudo apt-get update
sudo apt-get install -y curl

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# Sublimetext: https://www.sublimetext.com/docs/3/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https  #Ensure apt is set up to work with https sources
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

sudo add-apt-repository -y ppa:aacebedo/fasd
sudo apt-get update
sudo apt-get install -y fasd

sudo add-apt-repository -y ppa:hluk/copyq
sudo apt-get update
sudo apt install -y copyq

sudo apt install -y xclip

sudo apt install -y nautilus-dropbox

sudo add-apt-repository -y universe
sudo apt-get update
sudo apt-get install -y libgconf2-4 libnss3-1d libxss1

sudo apt-get install -y wkhtmltopdf

sudo apt install -y docker.io

sudo apt-get install -y bleachbit

# Because: http://askubuntu.com/questions/856659/backup-does-not-work-on-ubuntu-16-10-and-16-04
sudo apt-get install -y duplicity

# Preview (http://www.omgubuntu.co.uk/2016/09/gnome-sushi-mac-quick-look-nautilus)
sudo apt-get install -y gnome-sushi

# http://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html
sudo apt install -y xdotool

# Vagrant
sudo apt install -y vagrant

# Power management
sudo apt install -y tlp tlp-rdw
sudo tlp start

sudo apt install -y dconf-editor

sudo add-apt-repository -y ppa:unit193/encryption
sudo apt update
sudo apt install -y veracrypt

sudo apt install -y ranger

# https://extensions.gnome.org/
sudo apt-get install -y chrome-gnome-shell

# Database
sudo apt install -y postgresql-client-common
sudo apt install -y postgresql-client8

# Cisco VPN
sudo apt install -y network-manager-openconnect-gnome network-manager-openconnect openconnect vpnc openvpn vpnc-scripts

########################################################################################################################
## Apps that need atttention
########################################################################################################################

# Java
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java7-installer
sudo apt-get install -y oracle-java8-installer
# Java Cryptography Extension
sudo apt install -y oracle-java7-unlimited-jce-policy
sudo apt install -y oracle-java8-unlimited-jce-policy


# MySQL
if [ -f ! /etc/init.d/mysql* ]; then
    sudo apt-get install -y mysql-server
    # only run init script first time
    sudo mysql_secure_installation
fi

# VirtualBox
sudo apt install -y virtualbox-qt virtualbox-ext-pack


echo "Done installing!"
