#!/bin/bash

########################################
echo "Install oh-my-zsh"
yaourt -S oh-my-zsh-git neofetch
cp .zshrc ~
source ~/.zshrc

########################################
echo "Install chromium"
yaourt -S chromium

########################################
echo "Install Android Studio"
yaourt -S android-studio

########################################
echo "Install Gitkraken"
yaourt -S gitkraken
