#!/bin/bash

########################################
read -p 'Install oh-my-zsh? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S oh-my-zsh-git neofetch
    cp .zshrc ~
    source ~/.zshrc
fi

########################################
read -p 'Install noto fonts CJK? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S noto-fonts-cjk
fi

########################################
read -p 'Install chromium? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S chromium
fi

########################################
read -p 'Install Android Studio? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S android-studio
fi

########################################
read -p 'Install Gitkraken? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S gitkraken
fi

########################################
read -p 'Install VSCode? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S visual-studio-code-bin
fi

########################################
read -p 'Install Papirus Theme? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yay -S papirus-icon-theme-git arc-gtk-theme arc-kde
fi