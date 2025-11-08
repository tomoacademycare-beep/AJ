Start-Sleep -Seconds 2

$attempts = 0
$maxAttempts = 10

while ($attempts -lt $maxAttempts) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:4040/api/tunnels" -UseBasicParsing -ErrorAction Stop
        $data = $response.Content | ConvertFrom-Json
        
        $httpsUrl = $data.tunnels | Where-Object { $_.proto -eq "https" } | Select-Object -First 1
        
        if ($httpsUrl) {
            Write-Host ""
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host "Your ngrok Public URL:" -ForegroundColor Green
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host $httpsUrl.public_url -ForegroundColor Cyan
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host ""
            exit 0
        }
    } catch {
        Write-Host "." -NoNewline
    }
    
    Start-Sleep -Seconds 1
    $attempts++
}

Write-Host "Could not retrieve ngrok URL. Check http://localhost:4040 manually"
