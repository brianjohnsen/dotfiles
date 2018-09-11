#!/usr/bin/env bash


# fix for suspend occasionally fails
# https://askubuntu.com/questions/935672/ubuntu-16-04-on-dell-xps-suspend-occasionally-fails/938642#938642
echo "Creating file: /etc/pm/config.d/suspend_broardcom"
DIR="/etc/pm/config.d"
sudo mkdir $DIR
sudo cp ././../config/suspend_broardcom $DIR
sudo chmod 777 $DIR/suspend_broardcom
stat -c "%a %n" $DIR/suspend_broardcom
