import json
import os
import random
from typing import Any

from base import run_shell_command

CONFIG_PATH = os.path.expanduser("~/.config/sway/config.d/wallpaper.conf")
CONFIG_TEMPLATE_PATH = "./templates/wallpaper_template.conf"

WALLPAPERS_PATH = os.path.expanduser("~/dotfiles/assets/wallpapers")
SWWW_PATH = os.path.expanduser("~/dotfiles/assets/sys_bins/swww")


def get_random_wallpaper(color: str, path: str) -> str | None:
    walls = [wall for wall in os.listdir(path) if wall.startswith(color)]
    if not walls:
        return
    return random.choice(walls)


def update(_: str, color: str, extra_options: dict[str, Any]):
    wall_type = "live"
    wall_name = None

    if extra_options:
        _wall_type = extra_options.get("wallpaper_type")
        if _wall_type and _wall_type in ["static", "live"]:
            wall_type = _wall_type
        else:
            print("Wallpaper type not defined or invalid... 'live' selected")
        _wall_name = extra_options.get("wall_name")
        wallpapers = os.listdir(os.path.join(WALLPAPERS_PATH, wall_type))

        if _wall_name and _wall_name in wallpapers:
            wall_name = _wall_name
        else:
            print("Wallpaper name not defined or not found... Selecting at random")

    wallpapers_path = os.path.join(WALLPAPERS_PATH, wall_type)
    wall_name = wall_name if wall_name else get_random_wallpaper(color, wallpapers_path)
    if not wall_name:
        print(
            f"No wallpaper found for color '{color}' with type '{wall_type}'... Skipping"
        )
        return

    with open(CONFIG_TEMPLATE_PATH, "r") as f:
        template = f.read()

    new_file = template.replace(r"{{WALL_TYPE}}", wall_type).replace(
        r"{{WALL_NAME}}", wall_name
    )

    with open(CONFIG_PATH, "w") as f:
        f.write(new_file)

    run_shell_command(
        f"{SWWW_PATH} img {os.path.join(wallpapers_path, wall_name)} --transition-step 255"
    )
