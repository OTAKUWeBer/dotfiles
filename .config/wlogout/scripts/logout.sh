#!/bin/bash

if [ "$XDG_CURRENT_DESKTOP" = "" ]; then
    swaymsg exit  # For Sway
elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
    hyprctl dispatch exit  # For Hyprland
else
    echo "Unsupported environment"
fi
