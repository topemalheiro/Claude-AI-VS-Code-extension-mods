@echo off
REM Launch VS Code with Claude Code message width fix
REM Use this instead of launching VS Code directly

REM Run the fix script silently
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0fix-message-width.ps1" >nul 2>&1

REM Launch VS Code (pass any arguments through)
start "" "C:\Users\topem\AppData\Local\Programs\Microsoft VS Code\Code.exe" %*
