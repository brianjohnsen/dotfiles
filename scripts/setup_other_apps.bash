#!/usr/bin/env bash

echo "Installing non-apt software..."

# Lastpass
echo "Installing Lastpass..."
wget https://download.cloud.lastpass.com/linux/lplinux.tar.bz2
tar xjvf lplinux.tar.bz2
cd lplinux && ./install_lastpass.sh
rm lplinux.tar.bz2
rm -r lplinux
cd ..



echo "Done installing!"
