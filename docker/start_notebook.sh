#!/bin/bash

# 安裝所需的Python包
pip install -r /tmp/requirements.txt

# Jupyter Notebook
exec jupyter notebook --notebook-dir=/home/jovyan "$@"