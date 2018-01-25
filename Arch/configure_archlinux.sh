#!/bin/bash

########################################
read -p 'Install oh-my-zsh? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S oh-my-zsh-git neofetch
    cp .zshrc ~
    source ~/.zshrc
fi

########################################
read -p 'Install noto fonts CJK? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S noto-fonts-cjk
fi

########################################
read -p 'Install chromium? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S chromium
fi

########################################
read -p 'Install Android Studio? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S android-studio
fi

########################################
read -p 'Install Gitkraken? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S gitkraken
fi

########################################
read -p 'Install Atom? [Y]es/[N]o: ' input
if [ "$input" == "Y" -o "$input" == "y" ]
then
    yaourt -S atom
fi
