# 🛠️ Microsoft Repair Toolkit

📄 [中文说明](README.md) | [English](README.en.md)

一个一站式的 Windows 系统修复工具，专为解决 Microsoft Store 无法打开、系统服务被禁用（如 Windows Update）、以及系统文件损坏等问题设计。

该工具基于 PowerShell 脚本实现，支持菜单操作、自动提权、一键修复，无需用户具备脚本知识，开箱即用！

---

## ✨ 功能特性

- ✅ 修复 Windows Update、BITS 服务被禁用或权限错误问题
- ✅ 一键恢复 Microsoft Store 应用
- ✅ 自动执行 `SFC /scannow` 和 `DISM` 系统修复命令
- ✅ 提供 `.bat` 启动器，自动获取管理员权限运行 PowerShell
- ✅ 提供远程运行支持（通过 `irm | iex`）

---

## 📥 一键运行命令（无需下载 ZIP）

```powershell
irm "https://raw.githubusercontent.com/xiaoguaia/Microsoft-Repair-Toolkit/master/install.ps1" | iex
```

> 复制以上命令，在 PowerShell（管理员）中运行即可打开修复菜单

---

## 📁 文件说明

| 文件名                | 描述                               |
| --------------------- | ---------------------------------- |
| `win_repair_tool.ps1` | 主修复逻辑脚本（菜单、功能全）     |
| `install.ps1`         | 在线一键运行支持                   |
| `SetACL.exe`          | 权限修复工具，用于修复系统权限问题 |
| `README.md`           | 当前项目说明                       |
| `README.en.md`        | 英文版项目说明                     |
| `LICENSE`             | MIT 开源许可证                     |

---

## 📦 使用方法（本地方式）

1. **下载项目文件**

   - Clone 仓库或下载 ZIP 到本地
   - 解压到任意目录

2. **运行修复工具**

   - 右键 `win_repair_tool.ps1` → **以管理员身份运行**
   - 或在 PowerShell（管理员）中执行：`.\win_repair_tool.ps1`

3. **选择修复选项**
   - 根据菜单提示选择需要的操作（1-4）
   - 工具会自动执行相应的修复步骤

---

## 🧪 支持系统

- Windows 10 / 11
- 支持家庭版 / 专业版 / 教育版
- 不依赖第三方工具，纯系统调用

---

## 📄 开源许可

本项目使用 [MIT License](LICENSE) 授权，欢迎 Fork、改进或二次开发，但请保留原始作者信息。

---

## ❤️ 致谢

旨在解决日常系统问题，欢迎 Star & PR！

---
