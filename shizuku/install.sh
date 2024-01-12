#!/bin/sh
# Termux 安装 Shizuku
# 使用方法：wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/install.sh && sh install.sh
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.12

# Termux 安装函数
install() {
    # 下载 dex
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish_shizuku.dex -O  $PREFIX/bin/rish_shizuku.dex
    # 高于安卓14要求
    chmod 400 $PREFIX/bin/rish_shizuku.dex
    # 下载 rish
    wget https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/rish -O  $PREFIX/bin/rish
    # 修改rish里的包名
    sed -i "s/PKG/com.termux/" $PREFIX/bin/rish
    # 赋予执行权限
    chmod +x $PREFIX/bin/rish
    # 判断安装成功
    which rish && echo "Shizuku 安装成功!"
}

# 使用说明
usage() {
    echo "rish - 使用方法："
    echo "rish                # 进入交互式终端"
    echo "rish -c "command"     # 可执行单独命令"
    echo "欢迎加入 小贝塔教程资源 QQ群：773276432"
}

# 安装 Shizuku
if [ -f "$PREFIX/bin/rish" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read input
    if [ "$input" = "y" ]; then
        # 强删 dex
        rm -rf $PREFIX/bin/rish_shizuku.dex
        install && usage || echo "安装失败。退出！"
    fi
else
    install && usage || echo "安装失败。退出！"
fi
