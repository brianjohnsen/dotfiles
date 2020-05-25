#!/usr/bin/env bash

echo "Installing snaps..."

# Install: http://tldr.sh/
sudo snap install tldr

# Sublime Text
sudo snap install sublime-text --classic

# Slack
sudo snap install slack --classic

# Spotify
sudo snap install spotify

# IntelliJ
sudo snap install intellij-idea-ultimate --classic

# GitKraken
sudo snap install gitkraken

# Opera
sudo snap install opera

# Firefox
sudo snap install firefox

# Postman
sudo snap install postman


# magic-wormhole (https://github.com/warner/magic-wormhole)
sudo snap install wormhole

# newer version of firmware update manager (version fra apt is outdated)
sudo snap install fwupd --classic

echo "Done installing snaps!"
