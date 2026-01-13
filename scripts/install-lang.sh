#!/bin/bash
# Install fonts and update font cache

set -e  # exit if any command fails

# Install fonts
paru -S --skipreview noto-fonts noto-fonts-extra noto-fonts-cjk ttf-indic-otf

# Refresh font cache
fc-cache -fv

echo "Fonts installed and cache updated successfully."
