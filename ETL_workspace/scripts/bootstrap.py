# bootstrap.py
import os
import sys

def setup_path(level_up: int = 0):
    """
    自動將 project root（從當前檔案往上跳 level_up 層）加入 sys.path
    預設為當前檔案位置。
    """
    path = os.path.abspath(__file__)
    for _ in range(level_up):
        path = os.path.dirname(path)
    project_root = os.path.dirname(path)

    if project_root not in sys.path:
        sys.path.insert(0, project_root)

# 預設執行：往上 0 層，自身位置為 project root
setup_path(level_up=0)
