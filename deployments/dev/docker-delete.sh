#!/bin/sh

# 遇到错误时终止脚本的执行
set -e

# 父级目录路径、目录名
PARENT_PATH=$(
  cd "$(dirname "$0")"
  pwd
)
PARENT_NAME=$(basename "$PARENT_PATH")
# 项目目录路径、目录名
PROJECT_PATH=$(dirname "$(dirname "$(dirname "$PARENT_PATH")")")
PROJECT_NAME=$(basename "$PROJECT_PATH")

echo "---------- 当前站点的${PARENT_NAME}环境: 删除docker ----------"

# 删除镜像
docker rmi -f "${PROJECT_NAME}":"${PARENT_NAME}"

# 删除容器
docker rm -f "${PROJECT_NAME}"

echo ""
echo "---------- no shit ----------"
