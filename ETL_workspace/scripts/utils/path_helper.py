# utils/path_helper.py
# LLM output, do not understand yet

import sys
from pathlib import Path

def add_project_root():
    """
    自動將包含 config/, utils/, schema/ 的專案根目錄加入 sys.path，
    方便跨資料夾 import。
    """
    current_path = Path(__file__).resolve().parent
    for _ in range(5):  # 最多往上找 5 層
        if all((current_path / d).exists() for d in ["config", "utils", "schema"]):
            if str(current_path) not in sys.path:
                sys.path.insert(0, str(current_path))
                print(f"🧠 [add_project_root] Added to sys.path: {current_path}")
            return
        if current_path.parent == current_path:
            break
        current_path = current_path.parent

    print("⚠️ [add_project_root] Project root not found (missing config/, utils/, schema/)")
