#!/bin/bash

# Path to the wallpaper configuration file
WALLPAPER_CONF=$HOME/dotfiles/.config/hypr/config.d/wallpaper.conf

# Check if the wallpaper configuration file exists
if [[ ! -f "$WALLPAPER_CONF" ]]; then
    echo "Error: Wallpaper configuration file not found at $WALLPAPER_CONF"
    exit 1
fi

# Extract the wallpaper path from the configuration file
WALLPAPER=$(grep 'exec =' "$WALLPAPER_CONF" | sed 's/.*img //; s/ --.*//')

# Resolve tilde to full path
WALLPAPER=$(eval echo "$WALLPAPER")

# Check if the wallpaper path was successfully extracted
if [[ -z "$WALLPAPER" ]]; then
    echo "Error: No wallpaper path found in configuration."
    exit 1
fi

# Check if the wallpaper file exists
if [[ ! -f "$WALLPAPER" ]]; then
    echo "Error: Wallpaper file not found at $WALLPAPER"
    exit 1
fi

# Run Wallust with the extracted wallpaper
wallust run "$WALLPAPER"
clear

