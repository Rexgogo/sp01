# # utils/path_helper.py

# import os
# import sys

# def add_project_root():
#     """
#     將整個專案的根目錄加入到 sys.path，
#     這樣就能從任何子資料夾順利匯入像 config.xxx 或 transform.xxx 的模組。
#     """
#     try:
#         # 如果是 .py 檔案執行，使用 __file__ 取得目前這支 .py 的路徑
#         current_path = os.path.dirname(__file__)
#     except NameError:
#         # 如果是 Jupyter Notebook，__file__ 不存在，改用工作目錄
#         current_path = os.getcwd()

#     # 計算「上一層資料夾」作為專案根目錄
#     project_root = os.path.abspath(os.path.join(current_path, ".."))

#     # 如果還沒在 sys.path 裡，就加進去
#     if project_root not in sys.path:
#         sys.path.append(project_root)

# utils/path_helper.py

import os
import sys
from pathlib import Path

def find_project_root(required_dirs=["config", "utils", "schema"], max_levels=5):
    """
    自動往上找資料夾，只要找到同時包含 required_dirs 的目錄，就視為專案根目錄。
    """
    try:
        current_path = Path(__file__).resolve().parent
    except NameError:
        current_path = Path.cwd()

    for _ in range(max_levels):
        if all((current_path / d).exists() for d in required_dirs):
            return current_path
        if current_path.parent == current_path:
            break
        current_path = current_path.parent

    return None

def add_project_root():
    """
    自動加入專案根目錄（即包含 config/utils/schema 的那一層）到 sys.path
    """
    root = find_project_root()
    if root and str(root) not in sys.path:
        sys.path.insert(0, str(root))
        print(f"🧠 [add_project_root] Added to sys.path: {root}")
    elif not root:
        print("⚠️ [add_project_root] Failed to find project root — config/, utils/, schema/ not found upward.")
