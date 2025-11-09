# AJ Mini Balanced Server Startup Script
# Starts Flask API on port 5002 and ngrok tunnel
# Created by AJ STUDIOZ

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   AJ Mini Balanced Server Startup" -ForegroundColor Cyan
Write-Host "   Created by AJ STUDIOZ" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Python is installed
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python not found. Please install Python 3.8 or higher." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# Check if Ollama is running
Write-Host "Checking Ollama status..." -ForegroundColor Yellow
try {
    $ollamaStatus = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -Method GET -ErrorAction Stop
    Write-Host "✓ Ollama is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Ollama is not running. Starting Ollama..." -ForegroundColor Yellow
    Start-Process "ollama" -ArgumentList "serve" -WindowStyle Hidden
    Start-Sleep -Seconds 5
}

# Check if aj-mini-balanced model exists
Write-Host "Checking aj-mini-balanced model..." -ForegroundColor Yellow
try {
    $result = ollama list 2>&1 | Select-String "aj-mini-balanced"
    if ($result) {
        Write-Host "✓ aj-mini-balanced model found" -ForegroundColor Green
    } else {
        Write-Host "✗ aj-mini-balanced model not found. Please create it first." -ForegroundColor Red
        Write-Host "Run: ollama create aj-mini-balanced -f Modelfile-aj-mini-balanced" -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit
    }
} catch {
    Write-Host "⚠ Could not verify model existence" -ForegroundColor Yellow
}

# Navigate to the directory
Set-Location "d:\New folder (11)\aj-mini-balanced"

# Install dependencies if needed
if (!(Test-Path "venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
}

Write-Host "Installing/updating dependencies..." -ForegroundColor Yellow
.\venv\Scripts\pip install --quiet --upgrade pip
.\venv\Scripts\pip install --quiet -r requirements.txt

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting AJ Mini Balanced API Server" -ForegroundColor Green
Write-Host "Port: 5002" -ForegroundColor Yellow
Write-Host "Model: aj-mini-balanced (Balanced)" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "API Endpoints:" -ForegroundColor White
Write-Host "  http://localhost:5002/api/chat" -ForegroundColor Cyan
Write-Host "  http://localhost:5002/v1/chat/completions" -ForegroundColor Cyan
Write-Host "  http://localhost:5002/health" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start Flask server
.\venv\Scripts\python api_server.py

Write-Host ""
Write-Host "Server stopped." -ForegroundColor Red
Read-Host "Press Enter to exit"
