@echo off
REM Start AJ API + ngrok on Windows

setlocal enabledelayedexpansion

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0

REM Run PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%SCRIPT_DIR%start_ngrok.ps1' -ProjectPath '%SCRIPT_DIR%'"

pause
