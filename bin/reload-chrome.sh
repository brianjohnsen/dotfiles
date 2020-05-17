#!/usr/bin/env bash

#xdotool search --onlyvisible --class Chrome windowfocus --sync key ctrl+r


#xdotool search --class Chrome windowactivate --sync key F5 windowactivate $(xdotool getactivewindow)


# window where we came from
ORIGIN=$(xdotool getactivewindow)

# find PID of Chrome
#wid=$(xdotool search --onlyvisible --name "Terminal")
WID=$(xdotool search --onlyvisible --class Chrome)

# activate chrome window
xdotool windowactivate --sync $WID

sleep .5

# send keystroke
xdotool key 'ctrl+r'

# activate origin window
xdotool windowactivate --sync $ORIGIN
