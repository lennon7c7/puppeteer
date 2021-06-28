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

echo "---------- 进入docker ----------"

CMD_ARG=$1
if [ "${CMD_ARG}" == '' ]; then
  CMD_ARG="bash"
fi

# 进入容器
docker exec -i "$(docker ps --filter 'name='"${PROJECT_NAME}"'' --format '{{.Names}}')" sh -c "${CMD_ARG}"
