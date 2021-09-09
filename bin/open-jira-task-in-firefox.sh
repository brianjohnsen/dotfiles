#!/usr/bin/env bash

sh -c 'firefox "https://jira.erst.dk/browse/KOMP-$(xclip -o)"'


#KOMP-66
#sh -c firefox $(url)

#function open_url()
#{
#  local _open='firefox'
#
#  echo "Running: $_open $1"
#  $_open $1 &> /dev/null
#}

#urlen='loggen'
#jira=$(xclip -o)
#if [[ ${jira} =~ "KOMP" ]]; then
#    urlen="http://loggen/browse/${jira}"
#elif [[ ${jira} =~ "GUL" ]]; then
#    urlen="https://jira.ccta.dk/browse/${jira}"
#else
#    urlen="http://loggen/browse/KOMP-${jira}"
#fi



#WID=$(xdotool search --onlyvisible --name firefox)
#xdotool windowactivate --sync $WID
#sleep .5
#xdotool key 'ctrl+t'
#xdotool type --delay 10 ${urlen}
#
##xdotool key KP_Enter
#
#url() {
#  local jira=999
##  local jira=$(xclip -o)
#  if [[ ${jira} =~ "KOMP" ]]; then
#    echo "http://loggen/browse/${jira}"
#  elif [[ ${jira} =~ "GUL" ]]; then
#    echo "https://jira.ccta.dk/browse/${jira}"
#  else
#    echo "http://loggen/browse/KOMP-${jira}"
#  fi
#}
#
