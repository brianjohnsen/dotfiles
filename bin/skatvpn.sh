#!/bin/bash

username="XXX"
password="YYY"
url="webvpn.skat.dk"
#pidfile="/tmp/openconnect-pid"
group="DevOPS-ext"

copyq add $password #add to clipboard


# TJEK: https://github.com/dlenski/openconnect/issues/103

sudo openconnect --usergroup=$group --user=$username $url 
#sudo openconnect $url --usergroup=$group --user=$username --passwd-on-stdin <<< "Abcd1234"

# case "$1" in
# start)
#     #bad certs
#     #echo "$password" | openconnect -b --pid-file=$pidfile --no-cert-check --user=$username $url
#     echo "$password" | openconnect -b --pid-file=$pidfile --usergroup=$group --user=$username --background -s /usr/share/vpnc-scripts/vpnc-script $url 
#     ;;
# stop)
#     cat $pidfile  | xargs kill -2
#     ;;
# *)
#     echo "$0 <start|stop>"
#     exit 1
# esac