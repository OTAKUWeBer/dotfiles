#!/bin/bash

if [ "$XDG_CURRENT_DESKTOP" = "" ] || [ "$WAYLAND_DISPLAY" = "sway" ]; then
    exit 0 # Do nothing
elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] || [ "$WAYLAND_DISPLAY" = "hyprland" ]; then
    hyprlock
else
    echo "Unsupported environment"
fi
