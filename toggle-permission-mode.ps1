# Toggle Claude Code Permission Mode in VS Code
# Usage: powershell -ExecutionPolicy Bypass -File toggle-permission-mode.ps1 <mode>
# Modes: default, acceptEdits, plan, bypassPermissions
#
# Example: toggle-permission-mode.ps1 bypassPermissions

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("default", "acceptEdits", "plan", "bypassPermissions")]
    [string]$Mode
)

$settingsPath = "$env:APPDATA\Code\User\settings.json"

if (-not (Test-Path $settingsPath)) {
    Write-Error "VS Code settings.json not found at: $settingsPath"
    exit 1
}

# Read current settings
$settings = Get-Content $settingsPath -Raw | ConvertFrom-Json

# Update or add the permission mode setting
$settings | Add-Member -NotePropertyName "claudeCode.initialPermissionMode" -NotePropertyValue $Mode -Force

# Write back to file
$settings | ConvertTo-Json -Depth 100 | Set-Content $settingsPath

Write-Output "✓ Set permission mode to: $Mode"
Write-Output "✓ Location: $settingsPath"
Write-Output ""
Write-Output "Next steps:"
Write-Output "1. Start a NEW Claude conversation in VS Code"
Write-Output "2. Check the permission mode indicator in the UI"
Write-Output "3. It should show: $Mode"
