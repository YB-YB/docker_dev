#!/bin/bash

# 显示帮助信息
show_help() {
    echo "使用方法: switch_project [项目名称]"
    echo ""
    echo "如果不提供项目名称，将列出所有可用项目"
    echo ""
    echo "示例:"
    echo "  switch_project RuoYi-Vue3-FastAPI  # 切换到RuoYi-Vue3-FastAPI项目"
    echo "  switch_project                     # 列出所有可用项目"
}

# 列出所有可用项目
list_projects() {
    echo "可用项目:"
    ls -la /workspace | grep "^d" | awk '{print $9}'
}

# 主函数
main() {
    if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        show_help
        return 0
    fi

    if [ -z "$1" ]; then
        list_projects
        return 0
    fi

    if [ -d "/workspace/$1" ]; then
        cd "/workspace/$1"
        echo "已切换到项目: $1"
        echo "当前目录: $(pwd)"
    else
        echo "错误: 项目 '$1' 不存在"
        list_projects
        return 1
    fi
}

# 执行主函数
main "$@"