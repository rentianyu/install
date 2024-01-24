#!/system/bin/sh
brief_introduction() {
# shellcheck disable=SC2016
echo '

# 脚本用途：提取抓取桌面 Shortcut 的 Shell 命令
# 使用方法：su -c "dumpsys shortcut" >/sdcard/shortcuts.txt && bash -c "$(curl -s https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)"
# 项目地址：[小贝塔](https://github.com/rentianyu/install)
# 最后更新：2024.01.24
# QQ群：773276432

'
}
# 输入文件
IN=shortcut.txt
# 输出文件
OUT=/sdcard/shortcut_out.sh

# 处理函数
main() {
    grep -e "Package:.*UID" -e longLabel -e intents -e extras $1 |                 # 截取包名、卡片名称、主启动参数、附加启动参数
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
    sed -i '1iecho "说了不让你运行，你还运行，你得谢谢我！";exit 1' $OUT                              # 警示并退出函数
    echo -e "输出文件：$OUT\n输出文件：$OUT\n输出文件：$OUT"
}

# 调用函数
# 声明
brief_introduction

if [ -f "$IN" ]; then
    main "$IN"
# 无root、shizuku 询问安装shizuku
elif [ -f "/sdcard/$IN" ]; then
    main "/sdcard/$IN"
else
    echo "当前目录或 /sdcard 下没有 $IN 文件"
    echo "请先以 root、shizuku或adb shell权限运行："
    printf "\n    dumpsys shortcut /sdcard/shortcuts.txt  \n"
    echo "然后重试。"
fi
