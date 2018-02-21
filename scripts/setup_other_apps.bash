#!/usr/bin/env bash

echo "Installing non-apt software..."

# GitKraken
echo "Installing GitKraken..."
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
rm gitkraken-amd64.deb


# Lastpass
echo "Installing Lastpass..."
wget https://lastpass.com/lplinux.tar.bz2
tar xjvf lplinux.tar.bz2
cd lplinux && ./install_lastpass.sh
rm lplinux.tar.bz2
rm -r lplinux
cd ..



echo "Done installing!"
