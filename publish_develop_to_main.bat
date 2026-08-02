@echo off
cd /d "%~dp0"

echo ====================================================
echo     THE CHUBBY BABI - PUBLISH develop TO main
echo ====================================================
echo.
echo This will:
echo   1. Merge develop into main
echo   2. Push main to GitHub
echo   3. Sync develop back up to match main
echo.
set /p confirm="Continue? (y/n): "
if /i not "%confirm%"=="y" (
    echo Cancelled.
    pause
    exit /b
)

echo.
echo Checking out develop branch first...
git checkout develop

echo.
echo Checking for empty folders...
for /f "delims=" %%i in ('dir /ad /b /s ^| sort /r') do (
    dir /a /b "%%i" | findstr . >nul || (
        echo Keeping empty folder: %%~nxi
        echo. > "%%i\.gitkeep"
        attrib +h "%%i\.gitkeep"
    )
)

echo Committing any new .gitkeep files...
git add .
git commit -m "Auto-add .gitkeep to empty folders"

echo.
echo Syncing local develop with remote...
git checkout develop
git pull origin develop

echo.
echo Committing any pending changes or new .gitkeep files to develop...
git add .
git commit -m "Auto-add .gitkeep to empty folders"

echo.
echo Syncing local develop with remote...
git pull origin develop --no-edit

echo.
echo Switching to main and pulling latest...
git checkout main
git pull origin main --no-edit

echo.
echo Merging develop into main...
git merge develop --no-edit
if errorlevel 1 (
    echo.
    echo Merge conflict or error detected! Resolve conflicts manually, then
    echo re-run this script, or commit and push manually once resolved.
    pause
    exit /b
)

echo.
echo Pushing main to GitHub...
git push origin main

echo.
echo Switching back to develop and syncing with main...
git checkout develop
git merge main --no-edit
git push origin develop

echo.
echo ====================================================
echo Done! main and develop are now in sync.
echo ====================================================
pause