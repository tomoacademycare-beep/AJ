@echo off
REM Kill all python processes and restart Flask API

echo Stopping old Flask API processes...
taskkill /F /IM python.exe 2>nul

timeout /t 2 /nobreak

echo.
echo Starting Flask API with updated timeout (120 seconds)...
cd /d "%~dp0"
python api_server.py

echo.
echo If you see "Running on http://127.0.0.1:5000" above, the API is ready!
echo Your ngrok tunnel is still active at: https://cryptozygous-demetrice-homopolar.ngrok-free.dev/
echo.
pause
