@echo off
cd /d "%~dp0"

echo ====================================================
echo          THE CHUBBY BABI - PULLING CHANGES          
echo ====================================================
echo .
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
git push origin main
echo Done!
pause
