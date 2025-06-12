#!/bin/bash

# 如果设置了默认项目，则进入该项目目录
if [ -n "$DEFAULT_PROJECT" ] && [ -d "/workspace/$DEFAULT_PROJECT" ]; then
    cd "/workspace/$DEFAULT_PROJECT"
    echo "已进入默认项目目录: /workspace/$DEFAULT_PROJECT"
else
    cd /workspace
    echo "已进入工作空间目录: /workspace"
    echo "可用项目:"
    ls -la /workspace
fi

# 执行传入的命令或启动bash
if [ $# -eq 0 ]; then
    exec /bin/bash
else
    exec "$@"
fi