#!/bin/bash

# 定义要检查的文件路径
resolv_file="/etc/resolv.conf"

# 使用 grep 检查文件是否包含 "use-vc"
if ! grep -q "use-vc" "$resolv_file"; then
    # 如果文件中没有找到 "use-vc"，则在文件末尾添加
    echo "options use-vc" >> "$resolv_file"
    echo "Added 'options use-vc' to $resolv_file."
else
    echo "'use-vc' already exists in $resolv_file."
fi
