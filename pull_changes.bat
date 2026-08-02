@echo off
cd /d "%~dp0"

echo ====================================================
echo          THE CHUBBY BABI - PULLING CHANGES          
echo ====================================================
echo.

echo Available branches:
git branch -a
echo.

for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set current=%%b
echo You are currently on branch: %current%
echo.

set /p confirm="Pull into this branch? (y/n): "
if /i not "%confirm%"=="y" (
    echo Cancelled. Switch branch with "git checkout branch-name" and re-run.
    pause
    exit /b
)

echo.
echo Fetching latest updates from GitHub...
git pull origin %current%

echo.
echo Sync complete! Your local files are up to date.
echo.
pause