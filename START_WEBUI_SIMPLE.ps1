# ============================================================
# Open WebUI - Quick Start for AJ
# Created by AJ STUDIOZ
# ============================================================

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   OPEN WEBUI FOR AJ - QUICK START" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Open WebUI backend exists
$backendPath = "d:\New folder (11)\open-webui\backend"

if (Test-Path $backendPath) {
    Write-Host "Starting Open WebUI..." -ForegroundColor Yellow
    Write-Host ""
    
    Set-Location $backendPath
    
    # Start the backend
    Start-Process python -ArgumentList "-m uvicorn main:app --host 0.0.0.0 --port 8080" -WindowStyle Normal
    
    Start-Sleep -Seconds 5
    
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   OPEN WEBUI STARTED!" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Access at: http://localhost:8080" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Available Models:" -ForegroundColor Green
    Write-Host "- aj-mini-fast (Fast)" -ForegroundColor White
    Write-Host "- aj-mini (Pro)" -ForegroundColor White
    Write-Host ""
    Write-Host "First Time:" -ForegroundColor Yellow
    Write-Host "1. Open http://localhost:8080" -ForegroundColor White
    Write-Host "2. Create account" -ForegroundColor White
    Write-Host "3. Start chatting!" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    
} else {
    Write-Host "Open WebUI not set up yet!" -ForegroundColor Red
    Write-Host ""
    Write-Host "EASY ALTERNATIVE - Use Ollama's Built-in Web UI:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 1: Open WebUI via Docker (Recommended)" -ForegroundColor Green
    Write-Host "Run this command:" -ForegroundColor Yellow
    Write-Host 'docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main' -ForegroundColor White
    Write-Host ""
    Write-Host "Then open: http://localhost:3000" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Option 2: Use Web Interface from Browser" -ForegroundColor Green
    Write-Host "Visit: https://chat.openai.com alternative sites" -ForegroundColor White
    Write-Host "Or install Docker Desktop first for Option 1" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
