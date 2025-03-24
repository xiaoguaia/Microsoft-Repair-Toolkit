# 🛠 Microsoft Repair Toolkit (English)

A PowerShell-based repair toolkit to fix Microsoft Store issues, restore disabled system services like Windows Update, and run SFC / DISM to repair corrupted system files.

## ✨ Features

- ✅ Fix Windows Update / BITS service errors or permissions
- ✅ Restore Microsoft Store app
- ✅ Automatically execute `SFC /scannow` and `DISM`
- ✅ Includes `.bat` launcher with auto-elevation
- ✅ Supports one-line remote execution (`irm | iex`)

## 🚀 One-Line Execution

```powershell
irm "https://raw.githubusercontent.com/xiaoguaia/Microsoft-Repair-Toolkit/master/install.ps1" | iex
```

Run in PowerShell (as Administrator)

## 📁 Files

| Filename                        | Description                         |
| ------------------------------- | ----------------------------------- |
| `win_repair_tool.ps1`           | Main PowerShell repair logic        |
| `win_repair_tool_launcher.bat`  | Auto-elevated batch script launcher |
| `install.ps1`                   | Entry point for remote execution    |
| `README.zh.md` / `README.en.md` | Language-specific documentation     |

## 💻 Local Usage (ZIP method)

1. Clone this repository or download it as ZIP
2. Right-click `win_repair_tool_launcher.bat` → Run as Administrator
3. Follow the menu to perform repairs (options 1–4)

## 🧪 Supported Systems

- Windows 10 / 11
- All editions supported: Home / Pro / Education
- No third-party dependencies, fully system-native

## 🛡 License

This project is released under the [MIT License](LICENSE).  
You are free to Fork, modify, and redistribute it for any purpose.  
Please keep the original author attribution when applicable.

## ❤️ Acknowledgements

Project built to solve real-world system issues. Star & PR welcome!
