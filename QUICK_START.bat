@echo off
title AJ API + ngrok Quick Start
color 0A

cd /d "%~dp0"

echo.
echo ========================================
echo   AJ API + ngrok Quick Start Guide
echo ========================================
echo.
echo Step 1: RUNNING API and ngrok...
echo.

REM Start Flask API in background
echo Starting Flask API on port 5000...
start /B python api_server.py

timeout /t 3 /nobreak

REM Start ngrok in background
echo Starting ngrok tunnel...
start /B ngrok http 5000

timeout /t 3 /nobreak

echo.
echo ========================================
echo   SERVICES STARTED!
echo ========================================
echo.
echo Step 2: GET YOUR PUBLIC ngrok URL
echo Visit: http://localhost:4040
echo.
echo You will see your PUBLIC URL like:
echo https://xxxxx-xxxxx.ngrok.io
echo.
echo Step 3: OPEN THE WEB INTERFACE
echo Open index.html in your browser or:
echo http://localhost:5000
echo.
echo Step 4: PASTE YOUR ngrok URL
echo 1. Copy the HTTPS URL from http://localhost:4040
echo 2. Paste it into the "ngrok API URL" field in index.html
echo 3. Click "Save URL"
echo 4. Start chatting!
echo.
echo ========================================
echo   How to use AJ:
echo ========================================
echo - Write your question in the input field
echo - Press Send or Enter
echo - AJ will reply with perfect responses
echo.
echo Press Ctrl+C in this window to stop all services
echo.
pause
