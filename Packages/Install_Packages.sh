#!/bin/bash

# By Abdullah As-Sadeed

if [ -n "$SUDO_USER" ]; then
    echo -e "\e[31mPlease do not run with sudo!\e[0m"
    exit
fi

# Install yay
if ! command -v yay &>/dev/null; then
    # Trace mode
    set -x

    git clone https://aur.archlinux.org/yay-bin.git

    cd yay-bin || exit

    makepkg -si

    cd ..

    rm -rf yay-bin
fi

# Trace mode if not set
if [[ "$(set -o | grep xtrace)" == *"off"* ]]; then
    set -x
fi

sudo pacman -Syyu

sudo pacman -S --needed - <./pacman_Packages.txt

yay -S --needed - <./AUR_Packages.txt

sudo pacman -Rns $(pacman -Qtdq)

yay -Scc