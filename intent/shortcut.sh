#!/usr/bin/bash
brief_introduction() {
    # shellcheck disable=SC2016
    echo -e '简介：
# 抓取桌面shortcut的shell命令
# 使用方法：bash -c "$(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)""
# 作者：[小贝塔](https://github.com/rentianyu)
# 最后更新时间：2024.01.15
# QQ群：773276432
生成 Shortcut 的 Shell 命令的文件在：
$OUT
$OUT
$OUT
请勿执行该文件！
请勿执行该文件！
请勿执行该文件！'
}

# 一些变量
XBT="/storage/emulated/0/A-小贝塔"
IN="$XBT/shortcuts.txt"
OUT="$XBT/shortcuts.sh"

# 装shizuku
install_shizuku() {
    echo "无 Shizuku 环境"
    echo "是否安装 Shizuku 环境？(y/n)："
    read -r input
    if [ "$input" = "y" ]; then
        sh -c "$(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)"
    else
        echo "退出!"
        exit 1
    fi
}

# 生成 Shortcut 的 Shell 命令
main() {
    echo $OUT
    grep -e "Package:.*UID" -e longLabel -e intents -e extras "$1" |               # 截取包名、卡片名称、主启动参数、附加启动参数
        sed 's/.*Package:/\n# 软件包名:/g' |                                           # 包名
        sed "s/.*longLabel=/# /g;s/, resId.*//g" |                                 # 卡片名称
        sed "s/.*Intent { /am start --user 0 \'intent:#Intent/g; s/ }\/null]//g" | # 启动头
        sed 's/act=/;action=/g' |                                                  # intent 操作  # -a
        sed 's/ dat=/;/g' |                                                        # intent 数据 URI  # -d
        sed 's/ cmp=/;component=/g' |                                              # 带有软件包名称前缀的组件名称  # -n
        sed 's/ flg=/;launchFlags=/g' |                                            # 标记 # -f
        sed 's/ cat=\[/category=/g' |                                              # intent 类别  # -c
        sed 's/\]//g' |                                                            # 删除]
        sed 's/ pkg=/;package=/g' |                                                # 包名
        sed 's/}$//g' |                                                            # 删除结尾}，对应启动头删除{
        sed "s/.*'.*/\0;end'/g" |                                                  # 结尾标记
        sed 's/ }\/PersistableBundle\[{/;S./g' |                                   # 参数第一个变 .S  # -e
        sed 's/, /;S./g' |                                                         # 剩余参数变 .S 字符串
        sed 's/S\.\(\w\+\=[0-9]\{1,3\};\)/i.\1/g' |                                # .i 整数型数据  # --ei
        sed 's/S\.\(\w\+\=true;\)/B.\1/g' |                                        # .B 布尔值数据  # --ez
        sed 's/S\.\(\w\+\=false;\)/B.\1/g' |                                       # .B 布尔值数据  # --ez
        sed '/extras=null/d' |                                                     # intent 数据 URI
        sed "/ \+extras/s/;.*/'/g;/ \+extras/s/.*{\w\+\=/am start -d '/g" >$OUT    # intent 数据 URI
    [ -s "$1" ] && echo "处理成功" || echo "处理失败！处理失败！处理失败！"
}

# 判断是否是termux
cd ~ || exit 1
pwd | grep termux || echo -en "当前非 termux 软件！\n请用root权限运行或把要处理的shortcuts.txt放在同目录下"
cd - || exit 1

# 打印简介
brief_introduction

# 判断各情况
# root
if su -c "当前是root权限！"; then
    su -c "dumpsys shortcut" >"$XBT/shortcuts.txt"
    main "$XBT/shortcuts.txt"
# 小贝塔文件夹的 shortcuts.txt
elif [ -f $IN ]; then
    main "$IN"
# 当前目录的 shortcuts.txt
elif [ -f "shortcuts.txt" ]; then
    main "$IN"
# 无root、shizuku 询问安装shizuku
else
    echo "无 root权限或要处理的Shortcut ！"
    install_shizuku
    echo "退出!"
    exit 1
fi
