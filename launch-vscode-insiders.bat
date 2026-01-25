@echo off
REM Launch VS Code Insiders with Claude Code message width fix
REM Use this instead of launching VS Code Insiders directly

REM Run the fix script silently
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0fix-message-width-insiders.ps1" >nul 2>&1

REM Launch VS Code Insiders (pass any arguments through)
start "" "C:\Users\topem\AppData\Local\Programs\Microsoft VS Code Insiders\Code - Insiders.exe" %*
