#!/bin/bash
set -euo pipefail

# 遍历当前目录下所有 diff 文件
find . -name "*.diff" | while read -r patch; do
  # 去掉开头的 ./，得到相对路径
  clean_path="${patch#./}"
  rel_dir=$(dirname "$clean_path")

  # 打印命令
  echo "[INFO] Running: git am --directory=\"$rel_dir\" --reject \"$clean_path\""

  # 执行命令
  git am --directory="$rel_dir" --reject "$clean_path"
done
