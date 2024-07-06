# Dotfiles

This repository contains my personal dotfiles and configuration for setting up an Arch Linux environment with Wayland.

## Installation Instructions

1. **Install Arch Linux**: Install Arch Linux using any method you prefer.

2. **Chroot into your fresh Arch installation**:

3. **Install essential packages**:
    ```bash
    sudo pacman -Syu base-devel networkmanager network-manager-applet pipewire pavucontrol waybar bemenu-wayland foot wireguard-tools gnome-keyring git resolvconf xorg-xwayland mako cliphist github-cli stow sway zsh nodejs npm slurp grim thunar polkit xdg-desktop-portal xdg-desktop-portal-wlr vlc ttf-cascadia-code-nerd
    ```

4. **Install AUR helper (paru)**:
    ```bash
    cd /tmp
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si
    ```

5. **Install additional packages using `paru`**:
    ```bash
    paru -S wl-clip-persist-git catppuccin-gtk-theme-mocha papirus-folders-catppuccin-git
    ```

6. **Exit chroot and reboot**:
    ```bash
    exit
    reboot
    ```

7. **Enable and start NetworkManager and systemd-resolved services**:
    ```bash
    sudo systemctl enable --now NetworkManager.service
    sudo systemctl enable --now systemd-resolved.service
    ```

8. **Clone and apply dotfiles**:
    ```bash
    cd ~/
    git clone https://github.com/OTAKUWeBer/dotfiles
    cd dotfiles
    git submodule init
    git submodule update --depth=1
    stow -v .
    ```

## Additional Configuration

Ensure to customize the configuration files as needed to suit your preferences. 

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.
