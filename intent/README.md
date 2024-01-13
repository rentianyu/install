# 抓取安卓软件界面的 `Shell`脚本

## 1 简介

目前只适用于`Termux`终端使用.

## 2 注意事项

- 此工具理论上所有安卓版本适用
- root 权限、Shizuku权限都可
注：Shizuku相关支持会自动安装

## 3 安装

### 3.1 抓取桌面长按软件出现的touch图标、桌面图标

- 举例： 微信扫一扫、网易云音乐听歌识曲、微信小程序

- 打开 `Termux`，运行以下命令

```shell
# termux 请先安装 curl
apt update -y && apt install -y curl
# 安装脚本
sh <(curl -s https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)
```

- 安装完毕后，抓取的相关命令在文件`/sdcard/XBT/shortcut.sh`中，请自行查看，不要运行该脚本

- 

