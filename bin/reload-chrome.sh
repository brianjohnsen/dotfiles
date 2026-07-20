#!/usr/bin/env bash

# window where we came from
ORIGIN=$(xdotool getactivewindow)

# find the Chrome window
WID=$(xdotool search --onlyvisible --class Chrome)

# activate chrome window
xdotool windowactivate --sync "$WID"

sleep .5

# send keystroke
xdotool key 'ctrl+r'

# activate origin window (return focus to where we came from)
xdotool windowactivate --sync "$ORIGIN"
