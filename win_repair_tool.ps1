#requires -runasadministrator
Clear-Host
Write-Host "`n===== Windows 系统维护工具（PowerShell 版） =====" -ForegroundColor Cyan

Function Show-Menu {
    Write-Host ""
    Write-Host "1. 修复系统服务权限（如 Windows Update）"
    Write-Host "2. 恢复 Microsoft Store 应用"
    Write-Host "3. 执行系统文件检查（DISM 和 SFC）"
    Write-Host "4. 退出"
    Write-Host ""
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
    } Catch {
        Write-Host "❌ 修复失败，请确保以管理员身份运行。" -ForegroundColor Red
    }
}

Function Restore-Store {
    Write-Host "`n[正在恢复 Microsoft Store...]" -ForegroundColor Yellow
    Try {
        Get-AppxPackage -AllUsers Microsoft.WindowsStore | Foreach-Object {
            Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
        }
        Write-Host "✅ Store 恢复完成。" -ForegroundColor Green
    } Catch {
        Write-Host "❌ Store 恢复失败。" -ForegroundColor Red
    }
}

Function Run-DISM {
    Write-Host "`n[正在执行 SFC / DISM 修复，请稍候...]" -ForegroundColor Yellow
    sfc /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
    Write-Host "✅ 系统文件修复完成。" -ForegroundColor Green
}

do {
    Show-Menu
    $choice = Read-Host "请输入选项编号（1-4）"
    switch ($choice) {
        "1" { Fix-Services }
        "2" { Restore-Store }
        "3" { Run-DISM }
        "4" { Write-Host "退出程序，再见！" -ForegroundColor Cyan }
        default { Write-Host "无效选项，请重新输入。" -ForegroundColor Red }
    }
} while ($choice -ne "4")
