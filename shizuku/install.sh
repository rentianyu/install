#!/bin/sh
# Termux、MT管理器安装Shizuku
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.12

# 下载函数
download() {
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish_shizuku.dex -O rish_shizuku.dex
    [ -f "rish_shizuku.dex" ] || (echo "下载失败，退出！" ; exit 1)
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish -O rish
    [ -f "rish" ] || (echo "下载失败，退出！" ; exit 1)
}

# 使用说明
usage() {
    echo "使用方法："
    echo "rish                # 进入交互式终端"
    echo "rish -c "command"     # 可执行单独命令"
    echo "欢迎加入 小贝塔教程资源 QQ群：773276432"
}

# Termux、MT管理器安装函数
install() {
    mv -f rish_shizuku.dex ${PREFIX}${USR}/bin
    chmod 400 ${PREFIX}${USR}/bin/rish_shizuku.dex
    mv -f rish ${PREFIX}${USR}/bin
    chmod +x ${PREFIX}${USR}/bin/rish
    which rish && echo "Shizuku安装成功!"
}

# 1. 判断是否是安卓
uname -a | grep -q Android || (
    echo "不是安卓系统。退出！"
    exit 1
)

# 2. 判断软件包名
cd ~
if echo $PWD | grep -q termux; then
    PKG=$(echo $PWD | cut -d '/' -f 4)
elif echo $PWD | grep -q bin.mt.plus; then
    PKG=$(echo $PWD | cut -d '/' -f 5)
    USR='/usr'
else
    echo "不是MT管理器、Termux。退出！"
    exit 1
fi

# 3. 修改rish里的包名
sed -i "s/PKG/$PKG/" ${PREFIX}${USR}/bin/rish

# 4. 安装Shizuku
if [ -f "${PREFIX}${USR}/bin/rish" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read input
    if [ "$input" = "y" ]; then
        download ; install && usage || echo "安装失败。退出！"
    fi
else
    download ; install && usage || echo "安装失败。退出！"
fi
