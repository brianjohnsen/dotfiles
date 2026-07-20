#!/usr/bin/env bash

# Google the current X selection in Chrome.
sh -c 'google-chrome "https://www.google.com/search?q=$(xclip -o)"'
