# 抓取安卓软件界面的 `Shell`脚本

## 1 简介

抓取安卓软件界面的`Shell`脚本,目前只适用于`Termux`终端使用.

## 2 注意事项

- 此工具理论上所有安卓版本适用
- root 权限、Shizuku权限都可用

## 3 使用

### 3.1 抓取桌面长按软件出现的touch图标、桌面图标

- 举例： 微信扫一扫、网易云音乐听歌识曲、微信小程序


- root 用户

```shell
## 生成文件
su -c "dumpsys shortcut" >/sdcard/shortcuts.txt
# 然后运行处理脚本
bash -c "$(curl -s https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)"
```

- Shizuku 用户

```shell
# 安装 Shizuku 的 rish 命令到 Termux
bash -c "$(curl -s https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)"
# 生成文件
rish -c "dumpsys shortcut" >/sdcard/shortcuts.txt
# 然后运行处理脚本
bash -c "$(curl -s https://raw.githubusercontent.com/rentianyu/install/main/intent/shortcut.sh)"
```

- 运行完毕后，抓取的相关命令在文件`/sdcard/shortcut_out.sh`中，请自行查看，不要运行该脚本


