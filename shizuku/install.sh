#!/bin/sh
# Termux 安装 Shizuku
# 使用方法：sh <(curl -s https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/install.sh)
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.13

# Termux 安装函数
install() {
    # 下载 dex
    curl -s https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish_shizuku.dex >$DIR/rish_shizuku.dex
    # 下载 rish
    curl -s https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish >$DIR/rish
    # 修改rish里的包名
    sed -i "s/PKG/com.termux/" $DIR/rish
    # 赋予执行权限
    chmod +x $DIR/rish
    # 判断安装成功
    which rish && echo "Shizuku 安装成功!" || echo "安装失败。退出！"
}

# 使用说明
usage() {
    echo "rish - 使用方法："
    echo "rish                # 进入交互式终端"
    echo 'rish -c "command"     # 可执行单独命令'
    echo "欢迎加入 小贝塔教程资源 QQ群：773276432"
}

# 判断当前软件
cd ~
if pwd | grep com.termux; then
    DIR=$PREFIX/bin
    PKG=com.termux

elif pwd | grep bin.mt.plus; then
    echo "期待MT管理器支持！"
    echo "当前不是Termux环境，退出!"
    exit 1
    mkdir -p bin
    DIR=$HOME/bin
    PKG=$(pwd | cut -d '/' -f 5)
    [ -f .bashrc ] && {
        grep "$(pwd)/bin" .bashrc || echo "export PATH=$PATH:$(pwd)/bin" >>.bashrc
    } ||
        echo "export PATH=$PATH:$(pwd)/bin" >>.bashrc
else
    echo "当前不是Termux环境，退出!"
    exit 1
fi

# 安装 Shizuku
if [ -f "$DIR/rish" -a -f "$DIR/rish_shizuku.dex" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read input
    if [ "$input" = "y" ]; then
        # 强删 rish dex
        rm -rf $DIR/rish
        rm -rf $DIR/rish_shizuku.dex
        install && usage
    fi
else
    install && usage
fi
