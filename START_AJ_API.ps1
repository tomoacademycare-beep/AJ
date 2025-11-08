# ============================================================
# AJ API - COMPLETE STARTUP SCRIPT
# Created by AJ STUDIOZ
# ============================================================

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   AJ API SERVER - COMPLETE STARTUP" -ForegroundColor Green
Write-Host "   Created by AJ STUDIOZ" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Get current directory
$ProjectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectPath

# Step 1: Start API Server
Write-Host "[1/3] Starting API Server..." -ForegroundColor Yellow
Start-Process python -ArgumentList "api_server.py" -WindowStyle Minimized
Start-Sleep -Seconds 5

# Test if API is running
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5000/health" -UseBasicParsing -ErrorAction SilentlyContinue
    Write-Host "      ✓ API Server is running on port 5000" -ForegroundColor Green
} catch {
    Write-Host "      ⚠ API may still be starting..." -ForegroundColor Yellow
}

# Step 2: Start ngrok
Write-Host ""
Write-Host "[2/3] Starting ngrok tunnel..." -ForegroundColor Yellow
Start-Process ngrok -ArgumentList "http 5000" -WindowStyle Minimized
Start-Sleep -Seconds 6

Write-Host "      ✓ ngrok tunnel started" -ForegroundColor Green

# Step 3: Get ngrok URL
Write-Host ""
Write-Host "[3/3] Getting ngrok URL..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

try {
    $ngrokApi = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels" -ErrorAction SilentlyContinue
    $publicUrl = $ngrokApi.tunnels[0].public_url
    
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   STARTUP COMPLETE!" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Your ngrok Public URL:" -ForegroundColor Yellow
    Write-Host "$publicUrl" -ForegroundColor White
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   CURL TEST COMMANDS" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "1. Health Check (GET):" -ForegroundColor Yellow
    Write-Host "curl -X GET `"$publicUrl/health`" -H `"ngrok-skip-browser-warning: true`"" -ForegroundColor White
    Write-Host ""
    
    Write-Host "2. API Info (GET):" -ForegroundColor Yellow
    Write-Host "curl -X GET `"$publicUrl/api/info`" -H `"ngrok-skip-browser-warning: true`"" -ForegroundColor White
    Write-Host ""
    
    Write-Host "3. Chat Endpoint (POST):" -ForegroundColor Yellow
    Write-Host "curl -X POST `"$publicUrl/api/chat`" -H `"Content-Type: application/json`" -H `"ngrok-skip-browser-warning: true`" -d '{`"message`":`"Hello AJ, how are you?`"}'" -ForegroundColor White
    Write-Host ""
    
    Write-Host "4. Home Page (GET):" -ForegroundColor Yellow
    Write-Host "curl -X GET `"$publicUrl/`" -H `"ngrok-skip-browser-warning: true`"" -ForegroundColor White
    Write-Host ""
    
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   FOR REQBIN.COM" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "URL:" -ForegroundColor Yellow
    Write-Host "$publicUrl/api/chat" -ForegroundColor White
    Write-Host ""
    Write-Host "Method: POST" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Headers:" -ForegroundColor Yellow
    Write-Host "  Content-Type: application/json" -ForegroundColor White
    Write-Host "  ngrok-skip-browser-warning: true" -ForegroundColor White
    Write-Host ""
    Write-Host "Body (JSON):" -ForegroundColor Yellow
    Write-Host '{' -ForegroundColor White
    Write-Host '  "message": "Hello AJ, tell me a joke"' -ForegroundColor White
    Write-Host '}' -ForegroundColor White
    Write-Host ""
    
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "ngrok Dashboard: http://localhost:4040" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Press any key to open ngrok dashboard..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Start-Process "http://localhost:4040"
    
} catch {
    Write-Host "      ⚠ Could not retrieve ngrok URL" -ForegroundColor Red
    Write-Host "      Please visit http://localhost:4040 to get your URL" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Servers are running in the background." -ForegroundColor Green
Write-Host "To stop them, close the Python and ngrok windows." -ForegroundColor Yellow
Write-Host ""
