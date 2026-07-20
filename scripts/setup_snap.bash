#!/usr/bin/env bash

set -euxo pipefail

echo "Installing snaps..."

# Sublime Text
sudo snap install sublime-text --classic

# Slack
sudo snap install slack

# Opera
sudo snap install opera

# Firefox
sudo snap install firefox

# Postman
sudo snap install postman

# magic-wormhole (https://github.com/warner/magic-wormhole)
sudo snap install wormhole

# DBeaver
sudo snap install dbeaver-ce

# Inkscape (PDF editering)
sudo snap install inkscape


echo "Done installing snaps!"
