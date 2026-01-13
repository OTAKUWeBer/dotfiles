# dotfiles

This repository contains my personal dotfiles and configuration for setting up an Arch Linux environment with Wayland.

## Installation Instructions

1. **Chroot into your fresh Arch installation** (if installing from Arch ISO).

2. **Install Git**:
    ```bash
    sudo pacman -S git
    ```

3. **Clone the repository and run installer**:
    ```bash
    cd ~/
    git clone --depth 1 https://github.com/OTAKUWeBer/dotfiles
    cd dotfiles
    sudo chmod +x install-est.sh
    ./install-est.sh
    cd ..
    rm -rf dotfiles
    ```

4. **Exit chroot and reboot**:
    ```bash
    exit
    reboot
    ```

5. **Enable essential services**:
    ```bash
    sudo systemctl enable --now NetworkManager.service
    sudo systemctl enable --now systemd-resolved.service
    ```

6. **Install `paru` AUR helper**:
    ```bash
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    ```

7. **Apply dotfiles**:
    ```bash
    cd ~/
    git clone --depth 1 https://github.com/OTAKUWeBer/dotfiles
    cd dotfiles
    git submodule init && git submodule update --depth=1  # required for submodules
    stow -v .
    sudo chmod +x install-pkgs.sh
    ./install-pkgs.sh
    ```

8. **Activate Zsh**:
    ```bash
    chsh -s $(which zsh)
    ```

## Keybinds

Check the [keybinds.md](https://github.com/OTAKUWeBer/dotfiles/blob/main/keybinds.md) file for the keybind list.

## Additional Configuration

Customize the configuration files as needed to suit your preferences. 

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.
