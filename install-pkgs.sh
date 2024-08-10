#!/bin/bash

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    echo "paru could not be found. Installing paru..."
    cd /tmp
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si --noconfirm
    cd ~/
fi

# Install AUR packages with paru
paru -S --noconfirm wl-clip-persist-git catppuccin-gtk-theme-mocha papirus-folders-catppuccin-git swaylock oh-my-zsh swaybg brightnessctl swaynag noto-fonts-emoji blueman visual-studio-code-bin vlc ttf-cascadia-code-nerd
