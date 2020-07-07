#!/usr/bin/expect -f


#xdotool key super+3

set url "webvpn.skat.dk"
set group "DevOPS-ext"
set pwd "PASSWORD"
set password "SKAT PASSWORD"
set user "SKAT USERNAME"

spawn sudo openconnect --usergroup=$group --user=$user $url
expect "johnsen:"
send "$pwd\r";
expect "Password:"
send "$password\r";
interact

