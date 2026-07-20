#!/usr/bin/env bash

# No `-u`: bash-it's framework is not guaranteed to be unbound-variable clean,
# so `bash-it enable` could abort spuriously under `set -u`.
set -exo pipefail

echo "Setting up bash-it..."

# Load the bash-it CLI in this (non-interactive) shell. Sourcing ~/.bashrc does
# not work here because it returns early when non-interactive, so the `bash-it`
# function would be undefined. Source bash_it.sh directly instead.
# Trace off around the source - bash_it.sh init would flood install.log.
export BASH_IT="$HOME/.bash_it"
set +x
# shellcheck source=/dev/null
source "$BASH_IT/bash_it.sh"
set -x

echo "Setting up aliases"
bash-it enable alias general clipboard

echo "Setting up plugins"
bash-it enable plugin git history history-search sdkman zoxide alias-completion

echo "Setting up completions"
bash-it enable completion bash-it git gradle sdkman system

echo "Link custom stuff to .bash_it"
mkdir -p ~/.bash_it/custom/themes/brian
ln -sf ~/.dotfiles/bash-it-custom/themes/brian/brian.theme.bash ~/.bash_it/custom/themes/brian/brian.theme.bash
ln -sf ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/custom.aliases.bash
ln -sf ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/custom.bash
