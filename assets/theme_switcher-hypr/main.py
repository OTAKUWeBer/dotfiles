import importlib.util
import json
import os
import sys
from typing import Any

if not os.path.exists("config.json"):
    sys.exit("No config file found.")

config = json.load(open("config.json"))


def import_and_update(
    module_name, flavour: str, color: str, extra_options: None | dict[str, Any]
):
    module_path = f"{module_name}.py"
    spec = importlib.util.spec_from_file_location(module_name, module_path)
    if not spec:
        sys.exit(f"spec is {module_name} for {spec}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)  # type:ignore
    if hasattr(module, "update"):
        module.update(flavour, color, extra_options)


def update_theme(
    flavour: str, color: str, extra_options: None | dict[str, dict[str, Any]]
):
    current_file = os.path.basename(__file__)

    for file in os.listdir("./"):
        if (
            file.endswith(".py")
            and file != current_file
            and file.split(".")[0] not in config.get("exclude", [])
            and file != "base.py"
        ):
            module_name = os.path.splitext(file)[0]
            extra_opts = extra_options.get(module_name) if extra_options else None
            import_and_update(module_name, flavour, color, extra_opts)


if __name__ == "__main__":
    update_theme(config["flavour"], config["color"], config.get("extra_options"))
