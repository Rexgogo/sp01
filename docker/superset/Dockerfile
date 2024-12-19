FROM apache/superset:latest

# 设置工作目录
WORKDIR /app

# 复制 requirements-local.txt 到容器内
COPY requirements-local.txt .

# 安装依赖项
RUN pip install --no-cache-dir -r requirements-local.txt