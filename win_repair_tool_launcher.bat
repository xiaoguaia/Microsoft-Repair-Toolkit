@echo off
:: ===== 自动提权脚本头部 =====
:: 检查是否以管理员身份运行，如果不是则重新启动自己（带管理员权限）

:: 获取当前脚本的完整路径
set "script=%~f0"

:: 尝试写入一个系统目录文件以判断是否为管理员
fsutil dirty query %systemdrive% >nul 2>&1
if not %errorlevel%==0 (
    echo 当前未以管理员身份运行，正在尝试重新启动...
    powershell -Command "Start-Process '%script%' -Verb runAs"
    exit /b
)

:: ===== 实际脚本内容从这里开始 =====
title Windows 系统维护工具（自动提权版）
color 0a
cls
echo 成功以管理员身份运行！

:: 示例操作：调用 PowerShell 脚本运行主逻辑
powershell -ExecutionPolicy Bypass -File "%~dp0win_repair_tool.ps1"

pause
