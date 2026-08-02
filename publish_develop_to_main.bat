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
echo Checking for uncommitted changes...
for /f "delims=" %%i in ('git status --porcelain') do (
    echo.
    echo ERROR: You have uncommitted changes in your repository!
    echo Please commit or stash your work before running this script.
    pause
    exit /b
)

echo.
echo Checking for empty folders...
for /f "delims=" %%i in ('dir /ad /b /s ^| sort /r') do (
    dir /a /b "%%i" | findstr . >nul || (
        echo Keeping empty folder: %%~nxi
        echo. > "%%i\.gitkeep"
        attrib +h "%%i\.gitkeep"
    )
)

echo.
echo Committing any new .gitkeep files...
git add .
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Auto-add .gitkeep to empty folders"
) else (
    echo No empty folders to commit.
)

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
    echo Merge conflict or error detected! Resolve manually.
    pause
    exit /b
)

echo.
echo Pushing main to GitHub...
git push origin main
if errorlevel 1 goto permission_error

echo.
echo Switching back to develop and syncing...
git checkout develop
git merge main --no-edit
git push origin develop
if errorlevel 1 goto permission_error

echo.
echo Done! main and develop are now in sync.
pause
exit /b

:permission_error
echo.
echo ======================================================================
echo PUSH FAILED: You likely do not have write access to this repository.
echo ======================================================================
echo To submit your changes for review and merging, follow these steps:
echo 1. Go to https://github.com/bbelotti/Chubby-Babi-Cookbook
echo 2. Click "Fork" in the top right to create your own copy.
echo 3. Clone your forked repository to your local machine.
echo 4. Make your changes, commit, and push them to your fork.
echo 5. Go to the original repository page and click "New pull request".
echo ======================================================================
pause
exit /b