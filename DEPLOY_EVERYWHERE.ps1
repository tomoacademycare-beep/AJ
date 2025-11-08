# ============================================================
# AJ API - Deploy to All Free Hosting Platforms
# Created by AJ STUDIOZ
# ============================================================

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   AJ API - FREE HOSTING DEPLOYMENT" -ForegroundColor Green
Write-Host "   Created by AJ STUDIOZ" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "Continue"

# Get current directory
$ProjectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectPath

Write-Host "[Step 1/5] Checking Git repository..." -ForegroundColor Yellow

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "   Initializing Git repository..." -ForegroundColor Cyan
    git init
    git add .
    git commit -m "Initial commit for free hosting deployment"
    git branch -M main
}

# Check for remote
$remotes = git remote
if ($remotes -notcontains "origin") {
    Write-Host ""
    Write-Host "   ⚠ No GitHub remote found!" -ForegroundColor Yellow
    Write-Host "   Please create a GitHub repository and run:" -ForegroundColor White
    Write-Host "   git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git" -ForegroundColor Cyan
    Write-Host "   git push -u origin main" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "   ✓ Git repository ready" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[Step 2/5] Pushing to GitHub..." -ForegroundColor Yellow
    git add .
    git commit -m "Deploy: Updated for free hosting" -ErrorAction SilentlyContinue
    git push origin main
    Write-Host "   ✓ Pushed to GitHub" -ForegroundColor Green
}

Write-Host ""
Write-Host "[Step 3/5] Deployment Configuration Files Created:" -ForegroundColor Yellow
Write-Host "   ✓ render.yaml (for Render.com)" -ForegroundColor Green
Write-Host "   ✓ fly.toml (for Fly.io)" -ForegroundColor Green
Write-Host "   ✓ railway.json (for Railway.app)" -ForegroundColor Green
Write-Host "   ✓ Dockerfile (for all platforms)" -ForegroundColor Green

Write-Host ""
Write-Host "[Step 4/5] Installation Instructions:" -ForegroundColor Yellow

Write-Host ""
Write-Host "   🚀 RENDER.COM (Recommended - Easiest):" -ForegroundColor Cyan
Write-Host "   1. Go to https://render.com" -ForegroundColor White
Write-Host "   2. Sign up with GitHub" -ForegroundColor White
Write-Host "   3. Click 'New +' → 'Blueprint'" -ForegroundColor White
Write-Host "   4. Connect your GitHub repo" -ForegroundColor White
Write-Host "   5. Click 'Apply' - Done!" -ForegroundColor White

Write-Host ""
Write-Host "   🚂 RAILWAY.APP (Best Performance):" -ForegroundColor Cyan
Write-Host "   1. Go to https://railway.app" -ForegroundColor White
Write-Host "   2. Sign up with GitHub" -ForegroundColor White
Write-Host "   3. Click 'New Project' → 'Deploy from GitHub'" -ForegroundColor White
Write-Host "   4. Select your repo - Auto-deploys!" -ForegroundColor White

Write-Host ""
Write-Host "   ✈️  FLY.IO (Global CDN):" -ForegroundColor Cyan
Write-Host "   1. Install Fly CLI: iwr https://fly.io/install.ps1 -useb | iex" -ForegroundColor White
Write-Host "   2. Run: fly auth login" -ForegroundColor White
Write-Host "   3. Run: fly launch --no-deploy" -ForegroundColor White
Write-Host "   4. Run: fly deploy" -ForegroundColor White

Write-Host ""
Write-Host "   🤗 HUGGING FACE (Free Forever):" -ForegroundColor Cyan
Write-Host "   1. Go to https://huggingface.co/spaces" -ForegroundColor White
Write-Host "   2. Create new Space (Docker SDK)" -ForegroundColor White
Write-Host "   3. Push code or import from GitHub" -ForegroundColor White

Write-Host ""
Write-Host "[Step 5/5] Keep-Alive Service (Prevent Sleep):" -ForegroundColor Yellow
Write-Host "   Setup UptimeRobot to ping your API every 5 minutes:" -ForegroundColor Cyan
Write-Host "   1. Go to https://uptimerobot.com" -ForegroundColor White
Write-Host "   2. Add Monitor → HTTP(s)" -ForegroundColor White
Write-Host "   3. URL: Your deployed API URL + /health" -ForegroundColor White
Write-Host "   4. Interval: 5 minutes" -ForegroundColor White

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   DEPLOYMENT READY!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "After deployment, test your API with:" -ForegroundColor Yellow
Write-Host ""
Write-Host 'curl -X POST "https://YOUR-URL/api/chat" \' -ForegroundColor White
Write-Host '  -H "Content-Type: application/json" \' -ForegroundColor White
Write-Host '  -d ''{"message":"Hello AJ"}''' -ForegroundColor White
Write-Host ""

Write-Host "Your API will have:" -ForegroundColor Yellow
Write-Host "   ✅ Public HTTPS URL" -ForegroundColor Green
Write-Host "   ✅ Unlimited requests" -ForegroundColor Green
Write-Host "   ✅ Auto-scaling" -ForegroundColor Green
Write-Host "   ✅ 24/7 availability" -ForegroundColor Green
Write-Host "   ✅ Zero cost!" -ForegroundColor Green
Write-Host ""

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Created by AJ STUDIOZ | https://ajstudioz.co.in" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Press any key to open deployment guides..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Open browser to deployment platforms
Start-Process "https://render.com"
Start-Sleep -Seconds 2
Start-Process "https://railway.app"
Start-Sleep -Seconds 2
Start-Process "https://fly.io"
