@echo off
title AJ API Complete Startup
color 0A

echo ============================================================
echo    AJ API SERVER - COMPLETE STARTUP
echo    Created by AJ STUDIOZ
echo ============================================================
echo.

cd /d "%~dp0"

echo [1/3] Starting API Server...
start "AJ API Server" /MIN python api_server.py
timeout /t 5 /nobreak >nul

echo [2/3] Starting ngrok tunnel...
start "ngrok Tunnel" /MIN ngrok http 5000
timeout /t 5 /nobreak >nul

echo [3/3] Getting ngrok URL...
timeout /t 3 /nobreak >nul
powershell -ExecutionPolicy Bypass -File "get_ngrok_url.ps1"

echo.
echo ============================================================
echo    STARTUP COMPLETE!
echo ============================================================
echo.
echo Test your API with these curl commands:
echo.
echo 1. Health Check:
echo    curl -X GET "YOUR_NGROK_URL/health" -H "ngrok-skip-browser-warning: true"
echo.
echo 2. API Info:
echo    curl -X GET "YOUR_NGROK_URL/api/info" -H "ngrok-skip-browser-warning: true"
echo.
echo 3. Chat:
echo    curl -X POST "YOUR_NGROK_URL/api/chat" -H "Content-Type: application/json" -H "ngrok-skip-browser-warning: true" -d "{\"message\":\"Hello AJ\"}"
echo.
echo ============================================================
echo View ngrok dashboard: http://localhost:4040
echo ============================================================
echo.
echo Press any key to open ngrok dashboard...
pause >nul
start http://localhost:4040
