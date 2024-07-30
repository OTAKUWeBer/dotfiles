# Dotfiles

This repository contains my personal dotfiles and configuration for setting up an Arch Linux environment with Wayland.

## Installation Instructions

1. **Install Arch Linux**: Install Arch Linux using any method you prefer.

2. **Chroot into your fresh Arch installation**.

3. **Install `git`**:
    ```bash
    sudo pacman -S git
    ```

4. **Clone and apply dotfiles**:
    ```bash
    cd ~/
    git clone https://github.com/OTAKUWeBer/dotfiles
    cd dotfiles
    git submodule init
    git submodule update --depth=1
    stow -v .
    ```

5. **Run the installation script**:
    ```bash
    cd ~/dotfiles
    chmod +x install-packages.sh
    ./install-packages.sh
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

8. **Activating zsh**
    ```bash
    chsh -s $(which zsh)
    ```
    
## Additional Configuration

Ensure to customize the configuration files as needed to suit your preferences. 

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.