@echo off
cd /d "%~dp0"
git add .
set /p msg="Enter commit message: "
git commit -m "%msg%"
git push origin main
echo Done!
pause