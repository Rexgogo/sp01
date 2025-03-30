# gsheet_sources_loader.py

from pathlib import Path
import yaml 
import os
import sys


project_root = os.path.abspath(os.path.join(os.getcwd(), ".."))
if project_root not in sys.path:
    sys.path.insert(0, project_root)

yaml_path = Path(__file__).resolve().parent / "gsheet_sources.yaml"

with open(yaml_path, "r",encoding="utf-8") as f:
    gsheet_resources = yaml.safe_load(f)