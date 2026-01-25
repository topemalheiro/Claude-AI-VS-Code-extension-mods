# Fix Claude Code VS Code Extension - Full Width Messages
# Run this script after extension updates to restore full-width message box
# Auto-detects the CSS class name (changes with each extension version)
#
# Usage: powershell -ExecutionPolicy Bypass -File "fix-message-width.ps1"

$extensionPath = "$env:USERPROFILE\.vscode\extensions"
$claudeExtensions = Get-ChildItem $extensionPath -Directory | Where-Object { $_.Name -like 'anthropic.claude-code-*' }

foreach ($ext in $claudeExtensions) {
    $cssPath = Join-Path $ext.FullName 'webview\index.css'
    if (Test-Path $cssPath) {
        $css = Get-Content $cssPath -Raw
        # Auto-detect any 1-3 character class name with max-width:680px
        if ($css -match '\.([a-zA-Z]{1,3})\{max-width:680px;') {
            $className = $matches[1]
            $newCss = $css -replace "\.$className\{max-width:680px;", ".$className{max-width:100%;"
            Set-Content $cssPath -Value $newCss -NoNewline
            Write-Output "Fixed: $($ext.Name) (class: .$className)"
        } elseif ($css -match '\.([a-zA-Z]{1,3})\{max-width:100%;') {
            $className = $matches[1]
            Write-Output "Already fixed: $($ext.Name) (class: .$className)"
        } else {
            Write-Output "Different format: $($ext.Name)"
        }
    }
}

Write-Output "`nDone! Reload VS Code to see changes (Ctrl+Shift+P -> Developer: Reload Window)"
