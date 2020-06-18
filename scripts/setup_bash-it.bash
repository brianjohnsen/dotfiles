#!/usr/bin/env bash

source ~/.bashrc

echo "Setting up bash-it..."

echo "Setting up aliases"
bash-it enable alias general clipboard

echo "Setting up plugins"
bash-it enable plugin alias-completion fasd git history sdkman

echo "Setting up completions"
bash-it enable completion bash-it git gradle sdkman system

echo "Copy custom stuff to .bash_it"
cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/
cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/
