@echo off
cd /d "%~dp0"

echo ====================================================
echo          THE CHUBBY BABI - PUSHING CHANGES          
echo ====================================================
echo.

echo Available branches:
git branch -a
echo.

for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set current=%%b
echo You are currently on branch: %current%
echo.

set /p confirm="Push to this branch? (y/n): "
if /i not "%confirm%"=="y" (
    echo Cancelled. Switch branch with "git checkout branch-name" and re-run.
    pause
    exit /b
)

echo.
echo Checking for empty folders...
:: This finds empty folders and creates a .gitkeep file in them to make sure empty folders are also pushed
for /f "delims=" %%i in ('dir /ad /b /s ^| sort /r') do (
    dir /a /b "%%i" | findstr . >nul || (
        echo Keeping empty folder: %%~nxi
        echo. > "%%i\.gitkeep"
        attrib +h "%%i\.gitkeep"
    )
)

echo.
git add .
set /p msg="Enter commit message: "
git commit -m "%msg%"
git push origin %current%
if errorlevel 1 goto permission_error
echo Done!
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