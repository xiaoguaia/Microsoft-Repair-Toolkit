#requires -runasadministrator
Clear-Host
Write-Host "`n===== Windows 系统维护工具（PowerShell 版） =====" -ForegroundColor Cyan

Function Show-Menu {
    Write-Host ""
    Write-Host "0. 修复 Windows Update 注册表权限（推荐先运行）"
    Write-Host "1. 修复系统服务权限（如 Windows Update）"
    Write-Host "2. 恢复 Microsoft Store 应用"
    Write-Host "3. 执行系统文件检查（DISM 和 SFC）"
    Write-Host "4. 退出"
    Write-Host ""
}

Function Fix-ServicePermissions {
    Write-Host "`n[正在修复注册表权限...]" -ForegroundColor Yellow
    $setAclPath = "$PSScriptRoot\SetACL.exe"

    # 自动下载 SetACL.exe（首次使用）
    if (-not (Test-Path $setAclPath)) {
        Write-Host "首次使用，正在尝试下载 SetACL.exe ..." -ForegroundColor Yellow
        $setAclUrl = "https://raw.githubusercontent.com/xiaoguaia/Microsoft-Repair-Toolkit/master/SetACL.exe"

        try {
            Invoke-WebRequest -Uri $setAclUrl -OutFile $setAclPath -UseBasicParsing
            Write-Host "✅ SetACL.exe 下载完成。" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ 无法下载 SetACL.exe，请手动将其放入脚本目录中。" -ForegroundColor Red
            return
        }
    }

    Try {
        & $setAclPath -on "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" `
            -ot reg -actn setowner -ownr "n:Administrators"
        & $setAclPath -on "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" `
            -ot reg -actn ace -ace "n:Administrators;p:full"

        Write-Host "✅ 注册表权限已修复。" -ForegroundColor Green
    }
    Catch {
        Write-Host "❌ 权限修改失败，请确保以管理员身份运行。" -ForegroundColor Red
    }
}


Function Fix-Services {
    Write-Host "`n[正在修复 Windows Update 和 BITS 服务...]" -ForegroundColor Yellow
    Try {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv" -Name Start -Value 2 -ErrorAction Stop
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\BITS" -Name Start -Value 2 -ErrorAction Stop
        sc.exe config wuauserv start= auto | Out-Null
        sc.exe config bits start= delayed-auto | Out-Null
        Start-Service wuauserv -ErrorAction SilentlyContinue
        Start-Service bits -ErrorAction SilentlyContinue
        Write-Host "✅ 服务修复完成。" -ForegroundColor Green
    }
    Catch {
        Write-Host "❌ 修复失败，请确保以管理员身份运行。" -ForegroundColor Red
    }
}

Function Restore-Store {
    Write-Host "`n[正在恢复 Microsoft Store...]" -ForegroundColor Yellow
    Try {
        Get-AppxPackage -AllUsers Microsoft.WindowsStore | ForEach-Object {
            Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
        }
        Write-Host "✅ Store 恢复完成。" -ForegroundColor Green
    }
    Catch {
        Write-Host "❌ Store 恢复失败。" -ForegroundColor Red
    }
}

Function Run-DISM {
    Write-Host "`n[正在执行 SFC / DISM 修复，请稍候...]" -ForegroundColor Yellow
    sfc /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
    Write-Host "✅ 系统文件修复完成。" -ForegroundColor Green
}


Function Exit-Tool {
    Write-Host "正在清理临时文件..." -ForegroundColor Yellow
    $setAclPath = "$PSScriptRoot\SetACL.exe"
    if (Test-Path $setAclPath) {
        try {
            Remove-Item $setAclPath -Force
            Write-Host "✅ 已删除 SetACL.exe。" -ForegroundColor Green
        }
        catch {
            Write-Host "⚠️ 无法删除 SetACL.exe，请手动清理。" -ForegroundColor Red
        }
    }
    Write-Host "退出程序，再见！" -ForegroundColor Cyan
}


# 主菜单循环
do {
    Show-Menu
    $choice = Read-Host "请输入选项编号（0-4）"
    switch ($choice) {
        "0" { Fix-ServicePermissions }
        "1" { Fix-Services }
        "2" { Restore-Store }
        "3" { Run-DISM }
        "4" { Exit-Tool }
        default { Write-Host "无效选项，请重新输入。" -ForegroundColor Red }
    }
} while ($choice -ne "4")