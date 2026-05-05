@echo off
setlocal

echo BAT started
echo Current folder: %~dp0
echo Looking for: %~dp0send_mail.ps1
echo.

if not exist "%~dp0send_mail.ps1" (
    echo ERROR: send_mail.ps1 not found
    pause
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0send_mail.ps1"

echo.
echo Exit code: %ERRORLEVEL%
pause