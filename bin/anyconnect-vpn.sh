#!/usr/bin/env bash

## set ERST_VPN_PASSWORD in .bashrc
PASSWORD=${ERST_VPN_PASSWORD}

xdotool key "super" &
sleep .5
xdotool key type "cisco" &
sleep .5
xdotool key "Return" &
sleep .6
xdotool key "alt+c" &
sleep 3
xdotool key type $PASSWORD &
sleep .7
xdotool key "Return" &
