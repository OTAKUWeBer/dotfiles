import subprocess
from subprocess import CompletedProcess
from typing import Any


def run_shell_command(command: str) -> CompletedProcess[str]:
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: Command '{command}' failed with exit code {result.returncode}")
        print(f"stderr: {result.stderr}")
    return result


def base_update(colors: dict[str, Any], config_template_path: str, config_path: str):
    with open(config_template_path, "r") as f:
        template = f.read()

    for color, value in colors.items():
        place_holder = "{{" + color + "}}"
        hex = value["hex"]
        template = template.replace(place_holder, hex)

    with open(config_path, "w") as f:
        f.write(template)
