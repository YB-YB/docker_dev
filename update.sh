#!/bin/bash

echo "开始更新开发环境..."

# 停止并删除现有容器
echo "停止并删除现有容器..."
podman-compose down

# 重新构建容器
echo "重新构建容器..."
podman-compose build --no-cache

# 启动新容器
echo "启动新容器..."
podman-compose up -d

echo "更新完成！"
echo ""
echo "使用以下命令进入开发环境："
echo "docker exec -it dev-environment bash"
echo ""
echo "在容器内，你可以使用 switch_project 命令来切换项目目录："
echo "switch_project RuoYi-Vue3-FastAPI  # 切换到指定项目"
echo "switch_project                     # 列出所有可用项目"
