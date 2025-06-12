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

# 创建非root用户
RUN groupadd -r developer && useradd -r -g developer developer
RUN mkdir -p /home/developer && chown -R developer:developer /home/developer

# 设置工作目录权限
RUN chown -R developer:developer /app

# 切换到非root用户
USER developer

# 设置PATH以包含用户安装的npm全局包
ENV PATH="/home/developer/.local/bin:/home/developer/node_modules/.bin:${PATH}"

# 设置容器启动命令
CMD ["bash"]