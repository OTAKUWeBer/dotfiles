#!/bin/bash

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    echo "paru could not be found. Installing paru..."
    cd /tmp
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si --noconfirm
    cd ..
    rm -rf paru-bin
fi

# Update and install packages with pacman
sudo pacman -Syu --noconfirm base-devel networkmanager network-manager-applet pipewire pavucontrol waybar wf-recorder bemenu-wayland foot wireguard-tools gnome-keyring git resolvconf xorg-xwayland mako cliphist github-cli stow sway zsh nodejs npm slurp grim thunar polkit xdg-desktop-portal xdg-desktop-portal-wlr vlc ttf-cascadia-code-nerd

# Install AUR packages with paru
paru -S --noconfirm wl-clip-persist-git catppuccin-gtk-theme-mocha papirus-folders-catppuccin-git swaylock oh-my-zsh swaybg brightnessctl swaynag pulseaudio noto-fonts-emoji blueman visual-studio-code-bin
