# ============================================================
# Open WebUI - Simple Docker Setup for AJ
# Created by AJ STUDIOZ
# ============================================================

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   OPEN WEBUI FOR AJ" -ForegroundColor Green
Write-Host "   Beautiful ChatGPT-like Interface" -ForegroundColor Yellow
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Starting Open WebUI with Docker..." -ForegroundColor Yellow
Write-Host ""

# Run Open WebUI Docker container
docker run -d `
  -p 3000:8080 `
  --add-host=host.docker.internal:host-gateway `
  -v open-webui:/app/backend/data `
  --name open-webui `
  --restart always `
  ghcr.io/open-webui/open-webui:main

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   OPEN WEBUI STARTED!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Access Open WebUI at:" -ForegroundColor Yellow
Write-Host "http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "First time setup:" -ForegroundColor Green
Write-Host "1. Create an account (first user becomes admin)" -ForegroundColor White
Write-Host "2. Go to Settings > Connections" -ForegroundColor White
Write-Host "3. Set Ollama URL: http://host.docker.internal:11434" -ForegroundColor White
Write-Host "4. Your AJ models will appear automatically!" -ForegroundColor White
Write-Host ""
Write-Host "Available Models:" -ForegroundColor Green
Write-Host "✓ aj-mini-fast (recommended - fast & lightweight)" -ForegroundColor White
Write-Host "✓ aj-mini (powerful DeepSeek-R1:8B)" -ForegroundColor White
Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
