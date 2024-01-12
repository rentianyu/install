#!/bin/sh
# Termux、MT管理器安装Shizuku
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.12

# 下载函数
download() {
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish_shizuku.dex -O rish_shizuku.dex
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish -O rish
}

# 使用说明
usage() {
    echo "Shizuku安装成功!"
    echo "使用方法："
    echo "rish                  # 进入交互式终端"
    echo "rish -c "command"     # 可执行单独命令"
    echo "欢迎加入 小贝塔教程资源 QQ群：773276432"
}

# Termux、MT管理器安装函数
install() {
    [ -f "rish_shizuku.dex" ] || exit 1
    [ -f "rish" ] || exit 1
    mv -f rish_shizuku.dex $PREFIX/bin
    chmod 400 $PREFIX/bin/rish_shizuku.dex
    mv -f rish $PREFIX/bin
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
sed -i "s/PKG/$PKG/" $PREFIX/bin/rish

# 4. 安装Shizuku
if [ -f "$PREFIX/bin/rish" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read input
    if [ "$input" = "y" ]; then
        (download && install) && usage || echo "下载失败。退出！"
    fi
else
    (download && install) && usage || echo "下载失败。退出！"
fi
