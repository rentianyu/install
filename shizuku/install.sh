#!/usr/bin/bash
brief_introduction() {
    # shellcheck disable=SC2016
    echo '简介：
# Termux 安装 Shizuku
# 使用方法：bash -c "$(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)""
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.13
# QQ群：773276432'
}

# Termux 安装函数
install() {
    # 下载 dex
    curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/rish_shizuku.dex >"$DIR/rish_shizuku.dex"
    # 下载 rish
    curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/rish >"$DIR/rish"
    # 修改rish里的包名
    sed -i "s/PKG/$PKG/" "$DIR/rish"
    # 赋予执行权限
    chmod +x "$DIR/rish"
    # 判断安装成功
    [ -f "$DIR/rish" ] && [ -f "$DIR/rish_shizuku.dex" ] && printf "\n\n\nShizuku 安装成功!" || echo "安装失败。退出！"
}

# 使用说明
usage() {
    echo "$PKG" | grep -q bin.mt.plus && MT='sh ~/'
    printf "\nrish - 使用方法："
    echo "${MT}rish                # 进入交互式终端"
    echo "${MT}rish -c \"command\"     # 可执行单独命令"
    printf "欢迎加入 小贝塔教程资源 QQ群：773276432"
}

# 打印简介
brief_introduction() {

# 判断当前软件
cd ~ || exit
pwd | grep termux || echo "当前不是Termux环境，退出!" && exit 1

# 安装 Shizuku
if [ -f "$DIR/rish" ] && [ -f "$DIR/rish_shizuku.dex" ]; then
    echo "Shizuku已安装,是否重新安装？(y/n): "
    read -r input
    if [ "$input" = "y" ]; then
        # 强删 rish dex
        rm -rf "$DIR/rish*"
        install && usage
    fi
else
    install && usage
fi
