# Fix Claude Code VS Code Extension - Full Width Messages
# Run this script after extension updates to restore full-width message box
#
# Usage: powershell -ExecutionPolicy Bypass -File "fix-message-width.ps1"

$extensionPath = "$env:USERPROFILE\.vscode\extensions"
$claudeExtensions = Get-ChildItem $extensionPath -Directory | Where-Object { $_.Name -like 'anthropic.claude-code-*' }

foreach ($ext in $claudeExtensions) {
    $cssPath = Join-Path $ext.FullName 'webview\index.css'
    if (Test-Path $cssPath) {
        $css = Get-Content $cssPath -Raw
        if ($css -match '\.Qi\{max-width:680px;') {
            $newCss = $css -replace '\.Qi\{max-width:680px;', '.Qi{max-width:100%;'
            Set-Content $cssPath -Value $newCss -NoNewline
            Write-Output "Fixed: $($ext.Name)"
        } else {
            Write-Output "Already fixed or different format: $($ext.Name)"
        }
    }
}

Write-Output "`nDone! Reload VS Code to see changes (Ctrl+Shift+P -> Developer: Reload Window)"
