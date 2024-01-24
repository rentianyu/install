#!/usr/bin/bash
brief_introduction() {
    # shellcheck disable=SC2016
    echo '

# 脚本用途：Termux 安装 Shizuku
# 使用方法：bash -c "$(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)""
# 项目地址：[小贝塔](https://github.com/rentianyu/install)
# 最后更新：2024.01.24
# QQ群：773276432

'
}

# Termux 安装函数
install() {
    # 下载 dex
    curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/rish_shizuku.dex >"$1/rish_shizuku.dex"
    # 下载 rish
    curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/rish >"$1/rish"
    # 修改rish里的包名
    sed -i "s/PKG/$PKG/" "$1/rish"
    # 赋予执行权限
    chmod +x "$1/rish"
    # 判断安装成功
    [ -f "$1/rish" ] && [ -f "$1/rish_shizuku.dex" ] && printf "\n\n\nShizuku 安装成功!\n 请输入 rish 授权运行 shizuku 命令。\n\n\n" || echo "安装失败。退出！"
}

# 打印简介
brief_introduction

main() {
    # 安装路径
    DIR="$PREFIX/bin"

    # 安装 Shizuku
    if [ -f "$DIR/rish" ] && [ -f "$DIR/rish_shizuku.dex" ]; then
        echo "Shizuku已安装,是否重新安装？(y/n): "
        read -r input
        if [ "$input" = "y" ]; then
            # 强删 rish dex
            rm -rf "$DIR/rish*"
            install "$DIR"
        fi
    else
        install "$DIR"
    fi
}

# 判断当前软件
if echo "$PREFIX" | grep -q termux; then
    main
else
    echo "请在 Termux 环境下运行脚本!"
    exit 1
fi
