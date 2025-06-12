FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 避免Python生成.pyc文件和启用unbuffered模式
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    gnupg \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 安装Yarn
RUN npm install -g yarn

# 安装Python依赖管理工具
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 复制requirements.txt
COPY requirements.txt .

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 创建工作目录
RUN mkdir -p /app /workspace

# 设置PATH
ENV PATH="/home/developer/.local/bin:/home/developer/node_modules/.bin:${PATH}"

# 复制脚本
COPY app/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY app/switch_project.sh /usr/local/bin/switch_project
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/switch_project

# 设置工作目录
WORKDIR /workspace

# 设置入口点
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 设置容器启动命令
CMD ["bash"]