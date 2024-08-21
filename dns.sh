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

# 定义下载的文件 URL 和输出文件
URL="https://raw.githubusercontent.com/FlyBitVIP/ss/main/dns.json"
OUTPUT_FILE="/etc/XrayR/dns.json"

# 提示用户输入选择
read -p "请选择流媒体解锁地址 (1:香港, 2:日本, 3:新加披, 4:美国, 5:台湾): " choice

# 根据用户选择设置变量
if [ "$choice" == "1" ]; then
    DNS_M="$1"
elif [ "$choice" == "2" ]; then
    DNS_M="$2"
elif [ "$choice" == "3" ]; then
    DNS_M="$3"
elif [ "$choice" == "4" ]; then
    DNS_M="$4"
elif [ "$choice" == "5" ]; then
    DNS_M="$5"
else
    echo "无效选择！"
    exit 1
fi

# 下载文件
curl -o /home/tempdns.txt $URL

# 替换文件中的 {{IP}} 占位符
sed -e "s/{{IP}}/$DNS_M/g" /home/tempdns.txt > $OUTPUT_FILE

# 显示结果
echo "文件已生成: $OUTPUT_FILE"

# 删除临时文件
rm -rf /home/tempdns.txt

xrayr restart
