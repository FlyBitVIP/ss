#!/bin/bash

MY_HOST="$1"
MY_KEY="$2"
CONFIG_PATH="/etc/XrayR/config.yml"

# 定义下载的URL
url="https://raw.githubusercontent.com/FlyBitVIP/ss/main/xrayr-ss"

# 下载字符串
long_string=$(curl -s $url)

# 检查是否成功下载
if [ -z "$long_string" ]; then
  echo "无法从URL下载到模板文件"
  exit 1
fi

# 提示用户输入数值
read -p "请输入节点IP: " USER_INPUT_NODEID

# 将占位符替换为用户输入的数值
final_string=${long_string//"{NODEID}"/$USER_INPUT_NODEID}
final_string=${long_string//"{HOST}"/$MY_HOST}
final_string=${long_string//"{KEY}"/$MY_KEY}

# 将最终字符串写入到文件
echo "$final_string" > "$CONFIG_PATH"

# 提示用户操作成功
echo "成功更新配置文件： $CONFIG_PATH"

# 重启XrayR
xrayr restart
