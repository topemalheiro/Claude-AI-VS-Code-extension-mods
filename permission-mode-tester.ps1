# Claude Code Permission Mode Tester
# Simple GUI to test and verify permission mode changes
# Usage: powershell -ExecutionPolicy Bypass -File permission-mode-tester.ps1

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
} catch {
    Write-Error "Failed to load Windows Forms: $_"
    Read-Host "Press Enter to exit"
    exit 1
}

$settingsPath = "$env:APPDATA\Code\User\settings.json"

Write-Host "Settings path: $settingsPath"
Write-Host "File exists: $(Test-Path $settingsPath)"

# Function to get current mode
function Get-CurrentMode {
    if (Test-Path $settingsPath) {
        $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $mode = $settings.'claudeCode.initialPermissionMode'
        if ($mode) { return $mode }
    }
    return "default (not set)"
}

# Function to set mode
function Set-PermissionMode($mode) {
    if (-not (Test-Path $settingsPath)) {
        [System.Windows.Forms.MessageBox]::Show("VS Code settings.json not found!", "Error")
        return
    }

    $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
    $settings | Add-Member -NotePropertyName "claudeCode.initialPermissionMode" -NotePropertyValue $mode -Force
    $settings | ConvertTo-Json -Depth 100 | Set-Content $settingsPath

    $statusLabel.Text = "Current Mode: $mode"
    $statusLabel.ForeColor = [System.Drawing.Color]::Green

    [System.Windows.Forms.MessageBox]::Show(
        "Mode set to: $mode`n`nNext steps:`n1. Start NEW Claude conversation`n2. Check UI for mode indicator`n3. Verify it shows: $mode",
        "Success"
    )
}

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Claude Permission Mode Tester"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(20, 20)
$statusLabel.Size = New-Object System.Drawing.Size(350, 30)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$statusLabel.Text = "Current Mode: $(Get-CurrentMode)"
$form.Controls.Add($statusLabel)

# Instructions
$instructions = New-Object System.Windows.Forms.Label
$instructions.Location = New-Object System.Drawing.Point(20, 60)
$instructions.Size = New-Object System.Drawing.Size(350, 40)
$instructions.Text = "Click a button to change mode, then start a NEW Claude conversation to see the UI change."
$form.Controls.Add($instructions)

# Buttons
$yPos = 110
$modes = @("default", "acceptEdits", "plan", "bypassPermissions")

foreach ($mode in $modes) {
    $button = New-Object System.Windows.Forms.Button
    $button.Location = New-Object System.Drawing.Point(20, $yPos)
    $button.Size = New-Object System.Drawing.Size(350, 30)
    $button.Text = $mode
    $button.Tag = $mode
    $button.Add_Click({
        Set-PermissionMode $this.Tag
    })
    $form.Controls.Add($button)
    $yPos += 35
}

# Show form
$form.ShowDialog()
