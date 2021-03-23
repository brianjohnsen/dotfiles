#!/usr/bin/env bash

sudo mkdir -v -p /media/nc/logs-nine

if grep -qs '/logs-nine ' /proc/mounts; then
    echo "'/media/nc/logs-nine' is already mounted"
else
  sudo mount -v -t cifs -o credentials=~/.smbcredentials_nine_logs,uid=1000,vers=2.0 //samba.nonprod.es.local/logs-nine /media/nc/logs-nine
  sudo mount -v -t cifs -o credentials=~/.smbcredentials_nine_logs,uid=1000,vers=2.0 //samba.nonprod.es.local/logs-all /media/nc/logs-all
fi

