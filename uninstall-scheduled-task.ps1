# Uninstall Startup Shortcut for Claude Code Width Fix
#
# Usage: powershell -ExecutionPolicy Bypass -File "uninstall-scheduled-task.ps1"

$startupFolder = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupFolder "Claude Code Width Fix.lnk"

if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
    Write-Output "Startup shortcut removed."
} else {
    Write-Output "Startup shortcut not found."
}
