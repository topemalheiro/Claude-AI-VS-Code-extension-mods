# Fix Claude Code VS Code Extension - Full Width Messages (VS Code Insiders)
# Run this script after extension updates to restore full-width message box
# Replaces max-width:680px with max-width:100% (works regardless of class name format)
#
# Usage: powershell -ExecutionPolicy Bypass -File "fix-message-width-insiders.ps1"

$extensionPath = "$env:USERPROFILE\.vscode-insiders\extensions"
$claudeExtensions = Get-ChildItem $extensionPath -Directory | Where-Object { $_.Name -like 'anthropic.claude-code-*' }

foreach ($ext in $claudeExtensions) {
    $cssPath = Join-Path $ext.FullName 'webview\index.css'
    if (Test-Path $cssPath) {
        $css = Get-Content $cssPath -Raw

        # Simple approach: replace max-width:680px wherever it appears
        # This value is specific to the chat container, safe to replace globally
        if ($css -match 'max-width:680px') {
            $newCss = $css -replace 'max-width:680px', 'max-width:100%'
            Set-Content $cssPath -Value $newCss -NoNewline
            Write-Output "Fixed: $($ext.Name)"
        } elseif ($css -match 'max-width:100%.*margin:0 auto') {
            Write-Output "Already fixed: $($ext.Name)"
        } else {
            Write-Output "No 680px width found: $($ext.Name)"
        }
    }
}

Write-Output "`nDone! Reload VS Code Insiders to see changes (Ctrl+Shift+P -> Developer: Reload Window)"
