param([string]$ProjectPath = ".")

Set-Location $ProjectPath
Write-Host "Starting AJ API Server on port 5000..." -ForegroundColor Green
Start-Process python -ArgumentList "api_server.py" -WindowStyle Hidden

Write-Host "Waiting for API to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 4

Write-Host "Testing Flask API..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5000/" -UseBasicParsing -ErrorAction SilentlyContinue
    if ($response.StatusCode -eq 200) {
        Write-Host "Flask API is running successfully!" -ForegroundColor Green
    }
} catch {
    Write-Host "Flask not responding, but continuing..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Starting ngrok tunnel..." -ForegroundColor Green
Start-Process ngrok -ArgumentList "http 5000 --log=stdout" -WindowStyle Hidden

Write-Host "Waiting for ngrok to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Your AJ API is now publicly accessible!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "View your public URL here:" -ForegroundColor Yellow
Write-Host "http://localhost:4040" -ForegroundColor Cyan
Write-Host ""
Write-Host "Example API calls:" -ForegroundColor Yellow
Write-Host "  GET  /  (home)" -ForegroundColor White
Write-Host "  POST /api/chat  (send message)" -ForegroundColor White
Write-Host "  GET  /api/info  (model info)" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop both servers" -ForegroundColor Yellow
