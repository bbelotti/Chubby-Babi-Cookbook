@echo off
cd /d "%~dp0"

echo ====================================================
echo     THE CHUBBY BABI - PULL UPDATES
echo ====================================================
echo.

REM 1. Identify the current branch
for /f %%I in ('git rev-parse --abbrev-ref HEAD') do set current=%%I
echo Currently on branch: %current%
echo.

REM 2. Automatically configure the official repo as "upstream" if missing
git remote get-url upstream >nul 2>&1
if errorlevel 1 (
    echo Configuring 'upstream' remote...
    git remote add upstream https://github.com/bbelotti/Chubby-Babi-Cookbook.git
)

REM 3. Ask the user what kind of update they want
echo Where do you want to pull updates from?
echo [1] My own remote (origin) - Pull changes from my fork
echo [2] The official repository (upstream) - Get Bruno's latest updates
echo.
set /p choice="Enter 1 or 2: "

echo.
if "%choice%"=="1" (
    echo Pulling latest %current% from origin...
    git pull origin %current%
) else if "%choice%"=="2" (
    echo Pulling latest %current% from the official upstream repository...
    git pull upstream %current%
) else (
    echo Invalid choice. Aborting.
    pause
    exit /b
)

echo.
echo Done!
pause