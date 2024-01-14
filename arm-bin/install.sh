#!/system/bin/sh
# MT管理器安装一些命令到/data/local/tmp/bin
# 供adb或shizuku使用
# 作者：[小贝塔](https://github.com/rentianyu)
# 二进制文件来源：https://github.com/Zackptg5/Cross-Compiled-Binaries-Android
# 最后更新时间：2024.01.14

# 获取shizuku权限 POWER
power() {
    which rish && POWER=rish
    # shellcheck disable=SC2088
    # shellcheck disable=SC2034
    [ -f "~/rish" ] && [ -f "~/rish_shizuku.dex" ] && POWER="sh ~/rish"
}

# 装shizuku
install_shizuku() {
    echo "无 su 命令 或 Shizuku 环境"
    echo "是否安装 Shizuku 环境？(y/n)："
    read -r input
    if [ "$input" = "y" ]; then
        sh -c "$(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)"
    else
        echo "退出!"
        exit 1
    fi
}

install_bin(){
    DIR=/data/local/tmp/bin
    $POWER -c "'mkdir -p $DIR;
        for bin in jq sed grep; do
            curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/arm-bin/$bin -o $DIR/$bin && chmod +x $DIR/$bin;
        done;'"

}

power
echo $POWER
[ -n $POWER ] || install_shizuku && power
install_bin
