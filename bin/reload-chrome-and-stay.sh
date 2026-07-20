#!/usr/bin/env bash

# find the Chrome window
WID=$(xdotool search --onlyvisible --class Chrome)

# activate chrome window (and stay here)
xdotool windowactivate --sync "$WID"

sleep .5

# send keystroke
xdotool key 'ctrl+r'
