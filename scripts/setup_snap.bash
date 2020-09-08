#!/usr/bin/env bash

echo "Installing snaps..."

# Sublime Text
sudo snap install sublime-text --classic

# Slack
sudo snap install slack --classic

# Spotify
sudo snap install spotify

# IntelliJ
sudo snap install intellij-idea-ultimate --classic

# GitKraken
sudo snap install gitkraken --classic

# Opera
sudo snap install opera

# Firefox
sudo snap install firefox

# Postman
sudo snap install postman

# magic-wormhole (https://github.com/warner/magic-wormhole)
sudo snap install wormhole

# newer version of firmware update manager (version from apt is outdated)
sudo snap install fwupd --classic

# DBeaver
sudo snap install dbeaver-ce


echo "Done installing snaps!"
