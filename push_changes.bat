@echo off
cd /d "%~dp0"
echo ====================================================
echo          THE CHUBBY BABI - PUSHING CHANGES          
echo ====================================================
echo.
echo Available branches:
git branch -a
echo.
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set original=%%b
echo You are currently on branch: %original%
echo.
set /p target="Which branch do you want to push to? (main/develop): "
echo.

if /i not "%target%"=="%original%" (
    git checkout %target%
    if errorlevel 1 (
        echo.
        echo Could not switch to branch "%target%". Aborting.
        pause
        exit /b
    )
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
git push origin %target%
if errorlevel 1 goto permission_error
echo Done!
goto switch_back

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

:switch_back
if /i not "%target%"=="%original%" (
    echo.
    echo Switching back to your original branch: %original%
    git checkout %original%
)
pause
exit /b