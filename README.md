# Windows Repair Tool (PowerShell + Batch)

用于修复 Windows Store、系统服务（如 Windows Update）、执行 SFC / DISM 修复。

## 📁 文件说明

- `win_repair_tool.ps1`：主修复逻辑，PowerShell 脚本（UTF-8 编码）
- `win_repair_tool_launcher.bat`：自动提权启动器，调用 PowerShell 脚本
- `README.txt`：使用说明

## 🚀 使用方法

1. 解压此压缩包
2. 右键点击 `win_repair_tool_launcher.bat` → 以管理员身份运行
3. 按照菜单提示选择操作（修复服务 / Store / 执行系统检查）

## ✅ 功能菜单

1. 修复系统服务（如 Windows Update / BITS）
2. 恢复 Microsoft Store 应用
3. 执行系统文件修复（SFC / DISM）
4. 退出

## 🛠 注意事项

- 请以管理员身份运行
- 适用于 Windows 10 / 11
