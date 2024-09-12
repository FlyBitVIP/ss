#!/bin/bash

#  ==============================================================================
echo "往/etc/resolv.conf 添加 options use-vc"

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

# ==============================================================================
echo "生成/etc/XrayR/dns.json"

# 定义下载的文件URL
TEMP_URL="https://raw.githubusercontent.com/FlyBitVIP/ss/main/dns.json"
# 定义输出文件
OUTPUT_FILE="/etc/XrayR/dns.json"
# 定义dns数据文件
PRE_DNS_FILE="/home/pre_dns.txt"

# 输出提示
echo "序号 - 地区:"
awk -F '[. ]' '{print $1 ". " $2}' "$PRE_DNS_FILE"

# 提示用户输入选择
read -p "请选择流媒体解锁地区的序号: " choice

DNS_URL=$(grep "^$choice\." "$PRE_DNS_FILE" | awk '{print $2}')

# 判断密码是否存在
if [ -n "$DNS_URL" ]; then
    echo "序号 $choice 的密码是: $DNS_URL"
else
    echo "找不到对应序号 $choice 的密码"
    exit 1
fi

# 下载文件
curl -o /home/tempdns.txt $TEMP_URL

# 替换文件中的 {{URL}} 占位符
sed -e "s|URL|$DNS_URL|g" /home/tempdns.txt > $OUTPUT_FILE

# 显示结果
echo "文件已生成: $OUTPUT_FILE"

# 删除临时文件
rm -rf /home/tempdns.txt

xrayr restart
