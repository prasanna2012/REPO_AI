# RepoAI - PowerShell Startup Script for Windows

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "            RepoAI - Starting Development Server        " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please download Node.js (LTS) from https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit..."
    exit 1
}

# 2. Setup .env file
if (-not (Test-Path ".env")) {
    Write-Host "[SETUP] Creating .env from .env.example..." -ForegroundColor Green
    Copy-Item ".env.example" ".env"
}

# 3. Check node_modules
if (-not (Test-Path "node_modules")) {
    Write-Host "[NPM] Installing packages (first run)..." -ForegroundColor Yellow
    npm install --legacy-peer-deps
}

# 4. Start Server
Write-Host "[SERVER] Launching RepoAI on http://localhost:3000 ..." -ForegroundColor Green
Write-Host "Tip: Hold Ctrl and click http://localhost:3000 to open in your browser." -ForegroundColor Gray
Write-Host "Press Ctrl + C to stop the server." -ForegroundColor Gray
Write-Host ""

npm run dev
