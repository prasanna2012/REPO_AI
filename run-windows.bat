@echo off
TITLE RepoAI - Windows Starter
echo ========================================================
echo             RepoAI - Starting Development Server
echo ========================================================
echo.

:: Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed or not in PATH!
    echo Please install Node.js (v18+) from https://nodejs.org
    pause
    exit /b 1
)

:: Copy .env if not exists
if not exist .env (
    echo [.env] Creating .env file from .env.example...
    copy .env.example .env >nul
)

:: Install dependencies if node_modules is missing
if not exist node_modules (
    echo [NPM] Installing dependencies...
    call npm install --legacy-peer-deps
)

echo [SERVER] Starting RepoAI on http://localhost:3000 ...
echo Press Ctrl+C to stop the server anytime.
echo.
call npm run dev
pause
