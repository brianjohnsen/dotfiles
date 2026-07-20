#!/usr/bin/env bash

# Open the Jira issue whose number is on the X clipboard, e.g. clipboard "123"
# opens BFRI-123 in Firefox.
sh -c 'firefox "https://gennemtaenkt.atlassian.net/browse/BFRI-$(xclip -o)"'
