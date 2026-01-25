# Install Startup Shortcut for Claude Code Width Fix
# Runs the fix script automatically when Windows starts
#
# Usage: powershell -ExecutionPolicy Bypass -File "install-scheduled-task.ps1"

$scriptPath = Join-Path $PSScriptRoot "fix-message-width.ps1"
$startupFolder = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupFolder "Claude Code Width Fix.lnk"

# Create shortcut in Startup folder
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
$shortcut.WindowStyle = 7  # Minimized
$shortcut.Description = "Fixes Claude Code VS Code extension message width"
$shortcut.Save()

Write-Output "Startup shortcut created successfully!"
Write-Output "Location: $shortcutPath"
Write-Output ""
Write-Output "The fix will run automatically when you log in to Windows."
Write-Output ""
Write-Output "To remove: Delete the shortcut from your Startup folder"
Write-Output "Or run: Remove-Item `"$shortcutPath`""
