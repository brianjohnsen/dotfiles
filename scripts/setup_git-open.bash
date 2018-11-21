#!/usr/bin/env bash


# git open
echo "Installing git-open"
git clone git@github.com:brianjohnsen/git-open.git
cd git-open
sudo make install
cd ..
echo "Removing git-open repo"
rm -rf git-open