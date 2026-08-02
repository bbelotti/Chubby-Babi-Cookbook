@echo off
cd /d "%~dp0"

echo ====================================================
echo     THE CHUBBY BABI - PUBLISH develop TO main
echo ====================================================
echo.
echo This will:
echo   1. Update local develop from GitHub
echo   2. Merge develop into main
echo   3. Push main to GitHub
echo   4. Sync develop back up to match main
echo.

REM Fetch the current active branch name before running any conditional blocks
set "CURRENT_BRANCH=unknown"
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "CURRENT_BRANCH=%%b"

echo Checking for uncommitted changes...
git status --porcelain | findstr . >nul
if not errorlevel 1 (
    echo.
    echo WARNING: You have uncommitted changes in branch [ %CURRENT_BRANCH% ].
    echo Commit them first using push_changes.bat before publishing to main.
    pause
    exit /b
)

set /p confirm="Continue? (y/n): "
if /i not "%confirm%"=="y" (
    echo Cancelled.
    pause
    exit /b
)

echo.
echo Making sure local develop is up to date...
git checkout develop
if errorlevel 1 (
    echo.
    echo ERROR: Could not switch to develop. Aborting.
    pause
    exit /b
)
git pull origin develop
if errorlevel 1 (
    echo.
    echo ERROR: Could not pull develop from GitHub. Aborting.
    pause
    exit /b
)

echo.
echo Switching to main and pulling latest...
git checkout main
if errorlevel 1 (
    echo.
    echo ERROR: Could not switch to main. This usually means there are
    echo local changes blocking the checkout ^(e.g. new .gitkeep files^).
    echo Run "git status" to see what's blocking it, then re-run this script.
    pause
    exit /b
)
git pull origin main
if errorlevel 1 (
    echo.
    echo ERROR: Could not pull main from GitHub. Aborting.
    pause
    exit /b
)

echo.
echo Merging develop into main...
git merge develop
if errorlevel 1 (
    echo.
    echo Merge conflict or error detected! Resolve conflicts manually, then
    echo re-run this script, or commit and push manually once resolved.
    pause
    exit /b
)

echo.
echo Checking for empty folders...
REM This finds empty folders and creates a .gitkeep file in them to make sure empty folders are also pushed
for /f "delims=" %%i in ('dir /ad /b /s ^| sort /r') do (
    dir /a /b "%%i" | findstr . >nul || (
        echo Keeping empty folder: %%~nxi
        echo. > "%%i\.gitkeep"
        attrib +h "%%i\.gitkeep"
    )
)
git add .
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Add .gitkeep files for empty folders"
)

echo.
echo Pushing main to GitHub...
git push origin main
if errorlevel 1 (
    echo.
    echo ERROR: Push to main was rejected by GitHub. This can happen if
    echo main is a protected branch requiring a pull request instead of
    echo a direct push. Check the error above for details.
    pause
    exit /b
)

echo.
echo Switching back to develop and syncing with main...
git checkout develop
git merge main
git push origin develop

echo.
echo ====================================================
echo Done! main and develop are now in sync.
echo ====================================================
pause