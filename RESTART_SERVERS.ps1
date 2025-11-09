# Restart AJ API Servers
# This script stops and restarts the Flask API servers to apply changes

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   RESTARTING AJ API SERVERS" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Stop existing Python processes
Write-Host "[1/2] Stopping existing servers..." -ForegroundColor Yellow
Get-Process python -ErrorAction SilentlyContinue | Where-Object { $_.Path -like "*api_server.py*" -or $_.CommandLine -like "*api_server.py*" } | Stop-Process -Force
Start-Sleep -Seconds 2
Write-Host "      Servers stopped" -ForegroundColor Green

Write-Host ""
Write-Host "[2/2] Starting servers..." -ForegroundColor Yellow

# Start Fast server
Set-Location "d:\New folder (11)\aj-mini-fast"
Start-Process python -ArgumentList "api_server.py" -WindowStyle Minimized
Write-Host "      Fast server started (Port 5000)" -ForegroundColor Green

# Start Pro server (if needed)
# Set-Location "d:\New folder (11)\aj-mini-pro"
# Start-Process python -ArgumentList "api_server.py" -WindowStyle Minimized
# Write-Host "      Pro server started (Port 5001)" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   SERVERS RESTARTED!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Fast API: http://localhost:5000" -ForegroundColor Cyan
Write-Host "Pro API:  http://localhost:5001" -ForegroundColor Cyan
Write-Host ""
Write-Host "New endpoint added: /v1/chat/completions" -ForegroundColor Yellow
Write-Host "OpenAI-compatible for chatbot integration!" -ForegroundColor Green
Write-Host ""

Read-Host "Press Enter to exit"
