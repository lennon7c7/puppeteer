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
# 源码目录路径
SOURCE_CODE_PATH=$(dirname "$(dirname "$PARENT_PATH")")

echo "---------- 当前站点的${PARENT_NAME}环境: 构建docker ----------"

# 构建镜像
cd "$PARENT_PATH"
docker build -t "${PROJECT_NAME}":"${PARENT_NAME}" -f Dockerfile .

# 构建容器
docker run -d --restart=always -p 31030:31030 -v "${SOURCE_CODE_PATH}":/var/www/html --name "${PROJECT_NAME}" "${PROJECT_NAME}":"${PARENT_NAME}" /start.sh

echo ""
echo "---------- no shit ----------"
