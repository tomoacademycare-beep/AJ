Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   AJ API PRO - STARTING UP" -ForegroundColor Green
Write-Host "   Powerful DeepSeek-R1:8B Version" -ForegroundColor Yellow
Write-Host "   Created by AJ STUDIOZ" -ForegroundColor Yellow
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "d:\New folder (11)\aj-mini-pro"

Write-Host "[1/3] Starting API Server (Port 5001)..." -ForegroundColor Yellow
Start-Process python -ArgumentList "api_server.py" -WindowStyle Minimized
Start-Sleep -Seconds 5
Write-Host "      API Server started" -ForegroundColor Green

Write-Host ""
Write-Host "[2/3] Starting ngrok tunnel..." -ForegroundColor Yellow
Start-Process ngrok -ArgumentList "http 5001" -WindowStyle Minimized
Start-Sleep -Seconds 6
Write-Host "      ngrok tunnel started" -ForegroundColor Green

Write-Host ""
Write-Host "[3/3] Getting URL..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

try {
    $ngrokApi = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels"
    $publicUrl = $ngrokApi.tunnels[1].public_url
    
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   AJ PRO SERVER READY!" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "PUBLIC URL: $publicUrl/api/chat" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Note: First request will be slow (model loading)" -ForegroundColor Yellow
    Write-Host "Subsequent requests will be faster!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   FOR VERCEL CHATBOT PRODUCTION" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Your PERMANENT ngrok URL (already configured):" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "https://cryptozygous-demetrice-homopolar.ngrok-free.dev" -ForegroundColor White
    Write-Host ""
    Write-Host "This URL is already set in .env file!" -ForegroundColor Green
    Write-Host "Just deploy to Vercel and it will work!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Add this to Vercel Environment Variables:" -ForegroundColor Yellow
    Write-Host "OLLAMA_BASE_URL = https://cryptozygous-demetrice-homopolar.ngrok-free.dev" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   CURL COMMAND" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "curl -X POST \`"$publicUrl/api/chat\`" ``" -ForegroundColor White
    Write-Host "  -H \`"Content-Type: application/json\`" ``" -ForegroundColor White
    Write-Host "  -d '{`"message`":`"Hello AJ!`"}'" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "Dashboard: http://localhost:4040" -ForegroundColor Cyan
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "Visit http://localhost:4040 to get your URL" -ForegroundColor Yellow
}

Write-Host "Server running. Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
