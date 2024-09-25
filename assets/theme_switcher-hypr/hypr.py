import json
import os
from typing import Any

from base import run_shell_command

CONFIG_PATH = os.path.expanduser("~/dotfiles/.config/hypr/config.d/looks.conf")
CONFIG_TEMPLATE_PATH = "./templates/hypr_template.conf"


def base_update(colors: dict[str, Any], config_template_path: str, config_path: str):
    with open(config_template_path, "r") as f:
        template = f.read()

    for color, value in colors.items():
        place_holder = "{{" + color + "}}"
        hex = value["hex"].replace("#", "")
        template = template.replace(place_holder, hex)

    with open(config_path, "w") as f:
        f.write(template)


def update(flavour: str, color: str, _):
    theme = json.load(open("./themes/catppuccin.json")).get(flavour)
    if not theme or not theme.get("colors", {}).get(color):
        print(f"ERROR: Theme {flavour}-{color} not found for hypr... skipping")
        return

    theme["colors"]["main_colorscheme"] = theme["colors"][color]

    base_update(theme["colors"], CONFIG_TEMPLATE_PATH, CONFIG_PATH)
    run_shell_command("hyprctl reload")