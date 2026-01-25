# Claude AI VS-Code Extension Chatbox-Width Changer

PowerShell scripts to fix annoyances and customize the Claude Code VS Code extension.

## Scripts

| Script | Description |
|--------|-------------|
| `fix-message-width.ps1` | Full-width messages (VS Code stable) |
| `fix-message-width-insiders.ps1` | Full-width messages (VS Code Insiders) |

## Fix 1: Full-Width Messages

By default, the Claude Code extension limits message width to 680px, creating a narrow centered column. The `fix-message-width` scripts modify the CSS to allow messages to span the full width of the panel.

```powershell
# For VS Code (stable)
powershell -ExecutionPolicy Bypass -File "fix-message-width.ps1"

# For VS Code Insiders
powershell -ExecutionPolicy Bypass -File "fix-message-width-insiders.ps1"
```

## After Running Scripts

Reload VS Code to apply changes:
1. Press `Ctrl+Shift+P`
2. Type "Developer: Reload Window"
3. Press Enter

## Re-running After Updates

The Claude Code extension updates frequently. Each update overwrites the patched files, so you'll need to re-run the scripts after updates.

## How It Works

### Message Width Fix
Modifies `webview/index.css`, changing the message container's `max-width` from `680px` to `100%`.

**Note:** Since the CSS is minified, class names may change between versions. If the script reports "Already fixed or different format" but the fix isn't working, the class name likely changed.

To find the current class name:
```powershell
(Get-Content "$env:USERPROFILE\.vscode\extensions\anthropic.claude-code-*\webview\index.css" -Raw) -split '}' | Select-String 'max-width:680px'
```

### Windows Hide Fix
Modifies `extension.js`, changing:
```javascript
// Before (buggy - only works with Bun)
windowsHide: platform === "win32" && Dme()

// After (works with Node.js)
windowsHide: platform === "win32"
```

## Compatibility

- Tested with Claude Code extension version 2.1.11
- Windows only (PowerShell scripts)

## License

Apache-2.0
