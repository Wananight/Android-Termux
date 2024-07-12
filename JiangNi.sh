#!/bin/bash

version="Ver2.9.5"
clewd_version="$(grep '"version"' "clewd/package.json" | awk -F '"' '{print $4}')($(grep "Main = 'clewd修改版 v'" "clewd/lib/clewd-utils.js" | awk -F'[()]' '{print $3}'))"
st_version=$(grep '"version"' "SillyTavern/package.json" | awk -F '"' '{print $4}')
echo "hoping：卡在这里了？...说明有小猫没开魔法喵~"
latest_version=$(curl -s https://raw.githubusercontent.com/hopingmiao/termux_using_Claue/main/VERSION)
clewd_latestversion=$(curl -s https://raw.githubusercontent.com/teralomaniac/clewd/test/package.json | grep '"version"' | awk -F '"' '{print $4}')
clewd_subversion=$(curl -s https://raw.githubusercontent.com/teralomaniac/clewd/test/lib/clewd-utils.js | grep "Main = 'clewd修改版 v'" | awk -F'[()]' '{print $3}')
clewd_latest="$clewd_latestversion($clewd_subversion)"
st_latest=$(curl -s https://raw.githubusercontent.com/SillyTavern/SillyTavern/release/package.json | grep '"version"' | awk -F '"' '{print $4}')
saclinkemoji=$(curl -s https://raw.githubusercontent.com/hopingmiao/termux_using_Claue/main/secret_saclink | awk -F '|' '{print $3 }')

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 检查是否存在git指令
if command -v git &> /dev/null; then
    echo "git指令存在"
    git --version
else
    echo "git指令不存在，建议回termux下载git喵~"
fi

# 检查是否存在node指令
if command -v node &> /dev/null; then
    echo "node指令存在"
    node --version
else
    echo "node指令不存在，正在尝试重新下载喵~"
    curl -O https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-arm64.tar.xz
    tar xf node-v20.10.0-linux-arm64.tar.xz
    echo "export PATH=\$PATH:/root/node-v20.10.0-linux-arm64/bin" >> ~/.profile
    source ~/.profile
    if command -v node &> /dev/null; then
        echo "node成功下载"
        node --version                                                
    else
        echo "node下载失败，╮(︶﹏︶)╭，自己尝试手动下载吧"
        exit 1
    fi
fi

# 添加termux上的Ubuntu/root软链接
if [ ! -d "/data/data/com.termux/files/home/root" ]; then
    ln -s /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root /data/data/com.termux/files/home
fi

echo "root软链接已添加，可直接在mt管理器打开root文件夹修改文件
路径:/data/data/com.termux/files/home/root"

if [ ! -d "SillyTavern" ] || [ ! -f "SillyTavern/start.sh" ]; then
    echo "SillyTavern不存在，正在通过git下载..."
    git clone https://github.com/SillyTavern/SillyTavern SillyTavern
    echo -e "\033[0;33m本操作仅为破限下载提供方便，所有破限皆为收录，喵喵不具有破限所有权\033[0m"
    read -p "回车进行导入破限喵~"
    rm -rf /root/st_promot
    git clone https://github.com/hopingmiao/promot.git /root/st_promot
    if  [ ! -d "/root/st_promot" ]; then
        echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动预设文件下载失败了，更换网络后再试喵~\n\033[0m"
    else
        cp -r /root/st_promot/. /root/SillyTavern/public/'OpenAI Settings'/
        echo -e "\033[0;33m破限已成功导入，安装完毕后启动酒馆即可看到喵~\033[0m"
    fi
fi

if [ ! -d "clewd" ]; then
    echo "clewd不存在，正在通过git下载..."
    git clone -b test https://github.com/teralomaniac/clewd
    cd clewd
    bash start.sh
    cd /root
elif [ ! -f "clewd/config.js" ]; then
    cd clewd
    bash start.sh
    cd /root
fi

if [ ! -d "SillyTavern" ] || [ ! -f "SillyTavern/start.sh" ]; then
    echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动文件下载失败了，更换网络后再试喵~\n\033[0m"
    rm -rf SillyTavern
    exit 2
fi

if  [ ! -d "clewd" ] || [ ! -f "clewd/config.js" ]; then
    echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动文件下载失败了，更换网络后再试喵~\n\033[0m"
    rm -rf clewd
    exit 3
fi

# 主菜单
echo -e "                                              
喵喵一键脚本
作者：hoping喵(懒喵~)，水秋喵(苦等hoping喵起床)
版本：酒馆:$st_version clewd:$clewd_version 脚本:$version
最新：\033[5;36m酒馆:$st_latest\033[0m \033[5;32mclewd:$clewd_latest\033[0m \033[0;33m脚本:$latest_version\033[0m
来自：Claude2.1先行破限组
群号：704819371，910524479，304690608
类脑Discord(角色卡发布等): https://discord.gg/HWNkueX34q
此程序完全免费，不允许如浅睡纪元等人对脚本/教程进行盗用/商用。运行时需要稳定的魔法网络环境。"
while :
do 
    echo -e "\033[0;36mhoping喵~让你选一个执行（输入数字即可），懂了吗？\033[0;38m(｡ì _ í｡)\033[0m\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 退出脚本\033[0m
\033[0;33m选项1 启动Clewd\033[0m
\033[0;37m选项2 启动酒馆\033[0m
\033[0;33m选项3 Clewd设置\033[0m
\033[0;37m选项4 酒馆设置\033[0m
\033[0;33m选项5 神秘小链接$saclinkemoji\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项6 更新脚本\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了吗？
\033[0m\n(⇀‸↼‶)"
    read -r option
    case $option in
        0)
            echo "退出脚本"
            break
            ;;
        1)
            echo "启动Clewd"
            cd clewd
            nohup bash start.sh &>/dev/null &
            echo "Clewd已在后台启动"
            cd /root
            ;;
        2)
            echo "启动酒馆"
            cd SillyTavern
            nohup bash start.sh &>/dev/null &
            echo "酒馆已在后台启动"
            cd /root
            ;;
        3)
            echo "Clewd设置"
            # 在这里添加Clewd设置逻辑
            ;;
        4)
            echo "酒馆设置"
            # 在这里添加酒馆设置逻辑
            ;;
        5)
            echo "神秘小链接: $saclinkemoji"
            # 在这里添加神秘小链接
