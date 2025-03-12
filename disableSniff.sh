#!/bin/bash

CONFIG_FILE="/etc/XrayR/config.yml"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Config file '$CONFIG_FILE' not found."
  exit 1
fi

# 检查文件是否包含 DisableSniffing
if grep -q "DisableSniffing" "$CONFIG_FILE"; then
  echo "Config file '$CONFIG_FILE' already contains 'DisableSniffing'."
else
  # 在 EnableProxyProtocol: false 下面插入 DisableSniffing: true
  sed -i '/EnableProxyProtocol: false/a \      DisableSniffing: true' "$CONFIG_FILE"
  echo "Inserted 'DisableSniffing: true' into '$CONFIG_FILE'."
fi

echo "Config file check and modification completed."
exit 0
