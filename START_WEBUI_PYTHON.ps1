# ============================================================
# Open WebUI - Python Setup for AJ (No Docker Required)
# Created by AJ STUDIOZ
# ============================================================

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   OPEN WEBUI SETUP FOR AJ" -ForegroundColor Green
Write-Host "   No Docker Required!" -ForegroundColor Yellow
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "d:\New folder (11)\open-webui"

Write-Host "[1/4] Installing backend dependencies..." -ForegroundColor Yellow
Set-Location "backend"
pip install -r requirements.txt --quiet

Write-Host ""
Write-Host "[2/4] Creating environment file..." -ForegroundColor Yellow
$envContent = @"
# Open WebUI Configuration
ENV=dev
PORT=8080
OLLAMA_BASE_URL=http://localhost:11434
WEBUI_SECRET_KEY=aj-secret-key-2025
ENABLE_SIGNUP=true
ENABLE_LOGIN_FORM=true
DEFAULT_MODELS=aj-mini-fast;aj-mini
WEBUI_NAME=AJ Chat Interface
"@

Set-Content -Path ".env" -Value $envContent

Write-Host ""
Write-Host "[3/4] Installing frontend dependencies..." -ForegroundColor Yellow
Set-Location ".."
npm install --silent

Write-Host ""
Write-Host "[4/4] Building frontend..." -ForegroundColor Yellow
npm run build

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   SETUP COMPLETE!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Starting Open WebUI..." -ForegroundColor Yellow
Write-Host ""

# Start the backend server
Set-Location "backend"
Start-Process python -ArgumentList "-m uvicorn main:app --host 0.0.0.0 --port 8080 --reload" -WindowStyle Normal

Start-Sleep -Seconds 3

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   OPEN WEBUI IS RUNNING!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Access at: http://localhost:8080" -ForegroundColor Yellow
Write-Host ""
Write-Host "First Time Setup:" -ForegroundColor Green
Write-Host "1. Open http://localhost:8080 in your browser" -ForegroundColor White
Write-Host "2. Create an account (first user = admin)" -ForegroundColor White
Write-Host "3. Your AJ models will be available!" -ForegroundColor White
Write-Host ""
Write-Host "Available Models:" -ForegroundColor Green
Write-Host "- aj-mini-fast (Fast and Lightweight)" -ForegroundColor White
Write-Host "- aj-mini (Powerful Pro Version)" -ForegroundColor White
Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to stop the server..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
