#!/bin/sh

# 遇到错误时终止脚本的执行
set -e

# 父级目录路径、目录名
PARENT_PATH=$(
  cd "$(dirname "$0")"
  pwd
)
PARENT_NAME=$(basename "$PARENT_PATH")
# 源码目录路径
SOURCE_CODE_PATH=$(dirname "$(dirname "$PARENT_PATH")")

echo "---------- 当前站点的${PARENT_NAME}环境: 更新代码 ----------"

echo ""
echo "STEP1. 恢复代码"
cd "$SOURCE_CODE_PATH"
git checkout -- .

echo ""
echo "STEP2. 更新代码"
cd "$SOURCE_CODE_PATH"
git pull

echo ""
echo "STEP3. 因为已设置热更新，所以跳过执行api-ssr"
sleep 1

echo ""
echo "---------- no shit ----------"
