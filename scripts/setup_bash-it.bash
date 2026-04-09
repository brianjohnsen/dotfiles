#!/usr/bin/env bash

source ~/.bashrc

echo "Setting up bash-it..."

echo "Setting up aliases"
bash-it enable alias general clipboard

echo "Setting up plugins"
bash-it enable plugin git history history-search sdkman fasd alias-completion

echo "Setting up completions"
bash-it enable completion bash-it git gradle sdkman system

echo "Link custom stuff to .bash_it"
mkdir -p ~/.bash_it/custom/themes/brian
ln -sf ~/.dotfiles/bash-it-custom/themes/brian/brian.theme.bash ~/.bash_it/custom/themes/brian/brian.theme.bash
ln -sf ~/.dotfiles/bash-it-custom/aliases/custom.aliases.bash ~/.bash_it/aliases/custom.aliases.bash
ln -sf ~/.dotfiles/bash-it-custom/lib/custom.bash ~/.bash_it/lib/custom.bash
