# gsheet_sources_loader.py
from utils.path_helper import add_project_root
add_project_root()

from pathlib import Path
import yaml
import os
import sys


yaml_path = Path(__file__).resolve().parent.parent / "config" / "gsheet_sources.yaml"

with open(yaml_path, "r", encoding="utf-8") as f:
    gsheet_resources = yaml.safe_load(f)