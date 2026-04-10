#!/bin/bash
set -euo pipefail

# 先把文件放入数组，避免 while 在子 shell 中运行，作用是其中子命令冲突中断，整体命令中断，防止如果合并异常时继续打补丁，造成混乱
mapfile -t patches < <(find . -name "*.diff")

for patch in "${patches[@]}"; do
  clean_path="${patch#./}"
  rel_dir=$(dirname "$clean_path")

  echo "[INFO] Running: git am --directory=\"$rel_dir\" --reject \"$clean_path\""

  git am --directory="$rel_dir" --reject "$clean_path"
done