#!/usr/bin/env bash

## find PID of Chrome
WID=$(xdotool search --onlyvisible --class Chrome)

## activate chrome window
xdotool windowactivate --sync $WID

sleep .5

## send keystroke
xdotool key 'ctrl+r'
