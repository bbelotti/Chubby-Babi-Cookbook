@echo off
:: Set working directory to the folder where this script lives
cd /d "%~dp0"

echo ====================================================
echo          THE CHUBBY BABI - PULLING CHANGES          
echo ====================================================
echo.

echo Fetching latest updates from GitHub...
git pull origin develop

echo.
echo Sync complete! Your local files are up to date.
echo.
pause