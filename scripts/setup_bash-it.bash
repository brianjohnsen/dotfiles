#!/usr/bin/env bash

source ~/.bashrc

echo "Setting up bash-it..."

echo "Setting up aliases"
bash-it enable alias clipboard
bash-it enable alias general
bash-it enable alias general clipboard

echo "Setting up plugins"
bash-it enable plugin git
bash-it enable plugin history history-substring-search
bash-it enable plugin sdkman
bash-it enable plugin fasd
bash-it enable plugin alias-completion

echo "Setting up completions"
bash-it enable completion bash-it
bash-it enable completion git
bash-it enable completion gradle
bash-it enable completion sdkman
bash-it enable completion system

echo "Copy custom stuff to .bash_it"
cp -v ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/
cp -v ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/
