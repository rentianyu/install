# `Shizuku`安装脚本

## 1 简介

适用于 `Termux`、`FV悬浮球`、`MacDriod`的 `Shizuku`安装工具。

## 2 注意事项

- `root`用户不要运行了，有 `sui`。
- 此系列工具只能让目标软件可使用 `Shizuku`运行命令，并不能提升目标软件的权限。

## 3 安装

### 3.1 `Termux`安装 `Shizuku`

- 打开 `Termux`，运行以下命令

```shell
# termux 请先安装 curl
apt update -y && apt install -y curl
# 安装脚本
bash -c "$(curl -s https://raw.githubusercontent.com/rentianyu/install/main/shizuku/install.sh)"
```

- 安装完毕后，`rish`命令进入交互式终端，`rish -c "命令"`可执行单独命令

## 3.2 `FV悬浮球`安装 `Shizuku`

- `FV悬浮球`的任务分享平台搜索 `[β] 运行Shizuku命令(兼安装)`，安装并运行
- 或 下载 [FV-Shizuku.fvt](https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/FV-Shizuku.fvt)，导入 `FV悬浮球`运行

## 3.3 `MacDriod`安装 `Shizuku`

- 下载 [MacDriod-Shizuku-install.macro](https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/MacDriod-Shizuku-install.macro)，导入宏，按提示运行安装
- 导入调用动作块：[MacDriod-Shizuku-run.ablock](https://github.moeyy.xyz/https://raw.githubusercontent.com/rentianyu/install/main/shizuku/MacDriod-Shizuku-run.ablock)
