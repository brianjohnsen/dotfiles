#!/usr/bin/env bash

for dir in ~/PROJEKTER/ERST/*; do (cd "$dir" && pwd && git reset --hard origin/master); done