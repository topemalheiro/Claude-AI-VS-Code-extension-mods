# Claude Code Session Hook - Auto-fix chatbox width
# Runs on every Claude session start to catch mid-session VS Code updates
# Silent operation - no output to avoid popup windows

$ext = Get-ChildItem "$env:USERPROFILE\.vscode\extensions" -Dir | Where-Object { $_.Name -like 'anthropic.claude-code-*' } | Select-Object -Last 1
if ($ext) {
    $cssPath = Join-Path $ext.FullName 'webview\index.css'
    if (Test-Path $cssPath) {
        $css = Get-Content $cssPath -Raw
        if ($css -match '\.([a-zA-Z]{1,3})\{max-width:680px;') {
            $className = $matches[1]
            $newCss = $css -replace "\.$className\{max-width:680px;", ".$className{max-width:100%;"
            Set-Content $cssPath -Value $newCss -NoNewline
        }
    }
}
