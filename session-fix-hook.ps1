# Claude Code Session Hook - Auto-fix chatbox width
# Runs on every Claude session start to catch mid-session VS Code updates
# Silent operation - no output to avoid popup windows

$ext = Get-ChildItem "$env:USERPROFILE\.vscode\extensions" -Dir | Where-Object { $_.Name -like 'anthropic.claude-code-*' } | Select-Object -Last 1
if ($ext) {
    $cssPath = Join-Path $ext.FullName 'webview\index.css'
    if (Test-Path $cssPath) {
        $css = Get-Content $cssPath -Raw
        # Simple: replace max-width:680px wherever it appears (works with any class name)
        if ($css -match 'max-width:680px') {
            $newCss = $css -replace 'max-width:680px', 'max-width:100%'
            Set-Content $cssPath -Value $newCss -NoNewline
        }
    }
}
