#!/bin/sh

# 下载函数
download() {
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish_shizuku.dex -O rish_shizuku.dex
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish -O rish
}

# termux、MT管理器安装函数
install() {
    [ -f "rish_shizuku.dex" ] || exit 1
    [ -f "rish" ] || exit 1
    mv rish_shizuku.dex $PREFIX/bin
    chmod 400 $PREFIX/bin/rish_shizuku.dex
    mv rish $PREFIX/bin
    chmod +x $PREFIX/bin/rish
    which rish && echo "已安装"
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
else
    echo "不是MT管理器、Termux。退出！"
    exit 1
fi

# 3. 修改rish里的包名
sed -i "s/PKG/${PKG}//" $PREFIX/bin/rish

# 4. 安装Shizuku
if [ -f "$PREFIX/bin/rish" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read input
    if [ "$input" = "y" ]; then
        download && install || echo "下载失败。退出！"
    fi
else
    download && install || echo "下载失败。退出！"
fi
