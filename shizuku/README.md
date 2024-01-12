# `Shizuku`安装脚本

## 1 简介

适用于 `Termux`、`MT管理器`、`FV悬浮球`、`MacDriod`的 `Shizuku`安装工具

## 2 注意事项

`root`用户不要运行了，有 `sui`。

## 3 安装

### 3.1 `Termux`、`MT管理器`安装 `Shizuku`

打开 `Termux`或 `MT管理器`的终端界面，运行以下命令

```shell
# termux 请先安装 wget
apt update -y && apt install -y wget
# 安装脚本
sh <(wget -qO- https://cdn.jsdelivr.net/gh/rentianyu/install@main/shizuku/install.sh)
```

安装完毕后，`rish` 命令进入交互式终端，`rish -c "命令"` 可执行单独命令

## 3.2 `FV悬浮球`安装 `Shizuku`

- FV的任务分享平台搜索
