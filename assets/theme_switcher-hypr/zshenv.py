import json
import os

from base import base_update

CONFIG_PATH = os.path.expanduser("~/dotfiles/.zshenv")
CONFIG_TEMPLATE_PATH = "./templates/.zshenv_template"


def update(flavour: str, color: str, _):
    theme = json.load(open("./themes/catppuccin.json")).get(flavour)
    if not theme or not theme.get("colors", {}).get(color):
        print(f"ERROR: Theme {flavour}-{color} not found for hypr... skipping")
        return

    theme["colors"]["main_colorscheme"] = theme["colors"][color]

    base_update(theme["colors"], CONFIG_TEMPLATE_PATH, CONFIG_PATH)
