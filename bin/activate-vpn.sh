#!/usr/bin/expect -f


#xdotool key super+3

set url "webvpn.skat.dk"
set group "DevOPS-ext"
set pwd "$env(ROOT_ID)"
set password "$env(SKAT_PASSWORD)"
set user "$env(SKAT_WNUMMER)"

spawn sudo openconnect --usergroup=$group --user=$user $url
expect "johnsen:"
send "$pwd\r";
expect "Password:"
send "$password\r";
interact

