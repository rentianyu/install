#!/bin/bash
XBT=/storage/emulated/0/XBT
SHORTCU=$XBT/shortcuts.sh

# 判断是否有 sed 命令
which sed || {
    echo "无 sed 命令，正在安装 sed 命令！"
    apt update -y && apt install -y sed
}

# 判断是否有 su 命令 或 Shizuku 环境
if which su; then
    C=su
elif which rish; then
    C=rish
else
    echo "无 su 命令 或 Shizuku 环境"
    echo "是否安装 Shizuku 环境？(y/n)："
    read input
    if [ "$input" = "y" ]; then
        sh <(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)
        C=rish
    else
        echo "无 su 命令 或 Shizuku 环境"
        echo "退出!"
        exit 1
    fi
fi

# 生成 Shortcut 的 Shell 命令
C -c "dumpsys shortcut" |                                                       # 获取shortcut数据
    grep -e "Package:.*UID" -e longLabel -e intents -e extras |                 # 截取包名、卡片名称、主启动参数、附加启动参数
    sed 's/.*Package:/\n# 软件包名:/g' |                                            # 包名
    sed "s/.*longLabel=/# /g;s/, resId.*//g" |                                  # 卡片名称
    sed "s/.*Intent { /am start --user 0 \'intent:#Intent/g; s/ }\/null]//g" |  # 启动头
    sed 's/act=/;action=/g' |                                                   # intent 操作
    sed 's/ dat=/;/g' |                                                         # intent 数据 URI
    sed 's/ cmp=/;component=/g' |                                               # 带有软件包名称前缀的组件名称
    sed 's/ flg=/;launchFlags=/g' |                                             # 标记
    sed 's/ cat=\[/category=/g' |                                               # intent 类别
    sed 's/\]//g' |                                                             # 删除]
    sed 's/ pkg=/;package=/g' |                                                 # 包名
    sed 's/}$//g' |                                                             # 删除结尾}，对应启动头删除{
    sed "s/.*'.*/\0;end'/g" |                                                   # 结尾标记
    sed 's/ }\/PersistableBundle\[{/;S./g' |                                    # 参数第一个变 .S  # -e
    sed 's/, /;S./g' |                                                          # 剩余参数变 .S 字符串
    sed 's/S\.\(\w\+\=[0-9]\{1,3\};\)/i.\1/g' |                                 # .i 整数型数据  # --ei
    sed 's/S\.\(\w\+\=true;\)/B.\1/g' |                                         # .B 布尔值数据  # --ez
    sed 's/S\.\(\w\+\=false;\)/B.\1/g' |                                        # .B 布尔值数据  # --ez
    sed '/extras=null/d' |                                                      # intent 数据 URI
    sed "/ \+extras/s/;.*/'/g;/ \+extras/s/.*{\w\+\=/am start -d '/g" >$SHORTCU # intent 数据 URI

echo "生成 Shortcut 的 Shell 命令的文件在："
echo "$SHORTCU"
echo "请勿自行该文件！"
am start -a android.intent.action.VIEW -d file://$SHORTCU