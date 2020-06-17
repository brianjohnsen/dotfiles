#!/usr/bin/env bash

echo "========================================================================================="
echo ">> get-devices"
fwupdmgr get-devices
echo "========================================================================================="
echo ">> get-updates"
fwupdmgr get-updates
echo "========================================================================================="

read -p "Update firmware now (y/n)? " -n 1 -r
echo
case "$REPLY" in
  y|Y ) fwupdmgr update;;
  n|N ) echo "Exiting!";;
  * ) echo "Invalid!";;
esac
