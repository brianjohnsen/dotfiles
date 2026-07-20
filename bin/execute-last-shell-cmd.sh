#!/usr/bin/env bash

# window where we came from
ORIGIN=$(xdotool getactivewindow)

# find the gnome-terminal window
WID=$(xdotool search --onlyvisible --class gnome-terminal)

# activate Terminal window
xdotool windowactivate --sync "$WID"

sleep .2

# send keystrokes: re-run the last command
xdotool key 'Up'
sleep .2
xdotool key 'Return'
sleep .2

# activate origin window
xdotool windowactivate --sync "$ORIGIN"
