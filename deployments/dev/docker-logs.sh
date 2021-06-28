#!/bin/sh

# 遇到错误时终止脚本的执行
set -e

# 父级目录路径、目录名
PARENT_PATH=$(
  cd "$(dirname "$0")"
  pwd
)
# 项目目录路径、目录名
PROJECT_PATH=$(dirname "$(dirname "$(dirname "$PARENT_PATH")")")
PROJECT_NAME=$(basename "$PROJECT_PATH")

echo "---------- 查看容器日志 ----------"

docker logs -f "$(docker ps --filter 'name='"${PROJECT_NAME}"'' --format '{{.Names}}')" --tail 100
