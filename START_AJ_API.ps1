Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   AJ API - STARTING UP" -ForegroundColor Green
Write-Host "   Created by AJ STUDIOZ" -ForegroundColor Yellow
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "d:\New folder (11)"

Write-Host "[1/3] Starting API Server..." -ForegroundColor Yellow
Start-Process python -ArgumentList "api_server.py" -WindowStyle Minimized
Start-Sleep -Seconds 5
Write-Host "      API Server started on port 5000" -ForegroundColor Green

Write-Host ""
Write-Host "[2/3] Starting ngrok tunnel..." -ForegroundColor Yellow
Start-Process ngrok -ArgumentList "http 5000" -WindowStyle Minimized
Start-Sleep -Seconds 6
Write-Host "      ngrok tunnel started" -ForegroundColor Green

Write-Host ""
Write-Host "[3/4] Getting ngrok URL..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

try {
    $ngrokApi = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels"
    $publicUrl = $ngrokApi.tunnels[0].public_url
    
    Write-Host ""
    Write-Host "[4/4] Warming up model (first request)..." -ForegroundColor Yellow
    try {
        $warmup = Invoke-RestMethod -Uri "http://localhost:5000/api/chat" -Method Post -Headers @{"Content-Type"="application/json"} -Body '{"message":"hi"}' -TimeoutSec 180
        Write-Host "      Model ready! Response time will be faster now." -ForegroundColor Green
    } catch {
        Write-Host "      Warmup timeout, but model is loading..." -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   SERVER READY!" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "PUBLIC URL: $publicUrl/api/chat" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   CURL COMMAND" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "curl -X POST \`"$publicUrl/api/chat\`" ``" -ForegroundColor White
    Write-Host "  -H \`"Content-Type: application/json\`" ``" -ForegroundColor White
    Write-Host "  -d '{`"message`":`"Your question here`"}'" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   JAVASCRIPT CODE" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "fetch('$publicUrl/api/chat', {" -ForegroundColor White
    Write-Host "  method: 'POST'," -ForegroundColor White
    Write-Host "  headers: { 'Content-Type': 'application/json' }," -ForegroundColor White
    Write-Host "  body: JSON.stringify({ message: 'Hello AJ!' })" -ForegroundColor White
    Write-Host "})" -ForegroundColor White
    Write-Host ".then(res => res.json())" -ForegroundColor White
    Write-Host ".then(data => console.log(data.response));" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   HTML CHATBOT CODE" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "<!DOCTYPE html>" -ForegroundColor White
    Write-Host "<html><head><title>AJ Chat</title></head><body>" -ForegroundColor White
    Write-Host "<input id='msg' placeholder='Ask AJ...'>" -ForegroundColor White
    Write-Host "<button onclick='chat()'>Send</button>" -ForegroundColor White
    Write-Host "<div id='response'></div>" -ForegroundColor White
    Write-Host "<script>" -ForegroundColor White
    Write-Host "async function chat() {" -ForegroundColor White
    Write-Host "  const msg = document.getElementById('msg').value;" -ForegroundColor White
    Write-Host "  const res = await fetch('$publicUrl/api/chat', {" -ForegroundColor White
    Write-Host "    method: 'POST'," -ForegroundColor White
    Write-Host "    headers: {'Content-Type': 'application/json'}," -ForegroundColor White
    Write-Host "    body: JSON.stringify({message: msg})" -ForegroundColor White
    Write-Host "  });" -ForegroundColor White
    Write-Host "  const data = await res.json();" -ForegroundColor White
    Write-Host "  document.getElementById('response').innerText = data.response;" -ForegroundColor White
    Write-Host "}" -ForegroundColor White
    Write-Host "</script></body></html>" -ForegroundColor White
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "ngrok Dashboard: http://localhost:4040" -ForegroundColor Cyan
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "Visit http://localhost:4040 to get your URL" -ForegroundColor Yellow
}

Write-Host "Servers running in background. Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
