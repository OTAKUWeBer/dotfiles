#!/bin/bash
hyprctl reload
pkill waybar
waybar --config ~/dotfiles/.config/waybar-hypr/config.jsonc --style ~/dotfiles/.config/waybar-hypr/style.css
