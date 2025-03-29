# utils/path_helper.py

import os
import sys

def add_project_root():
    """
    將整個專案的根目錄加入到 sys.path，
    這樣就能從任何子資料夾順利匯入像 config.xxx 或 transform.xxx 的模組。
    """
    try:
        # 如果是 .py 檔案執行，使用 __file__ 取得目前這支 .py 的路徑
        current_path = os.path.dirname(__file__)
    except NameError:
        # 如果是 Jupyter Notebook，__file__ 不存在，改用工作目錄
        current_path = os.getcwd()

    # 計算「上一層資料夾」作為專案根目錄
    project_root = os.path.abspath(os.path.join(current_path, ".."))

    # 如果還沒在 sys.path 裡，就加進去
    if project_root not in sys.path:
        sys.path.append(project_root)