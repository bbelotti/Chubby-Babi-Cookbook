@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo ====================================================
    echo             THE CHUBBY BABI - RECIPE INDEX       
echo ====================================================
echo.

:: Loop through every subdirectory inside the current folder
for /d %%D in (*) do (
    echo --- %%~nD ---
    set "found=0"
    
    :: Initialize a temporary file to track processed recipes in this folder
    if exist "%temp%\recipes.txt" del "%temp%\recipes.txt"
    
    :: Loop through all .tex files starting with EN_
    for %%F in ("%%D\EN_*.tex") do (
        set "filename=%%~nF"
        set "corename=!filename:EN_=!"
        
        :: Check if the matching OL_ file exists
        if exist "%%D\OL_!corename!.tex" (
            echo   [BOTH] !corename!
        ) else (
            echo   [EN]   !corename!
        )
        echo !corename!>>"%temp%\recipes.txt"
        set "found=1"
    )
    
    :: Loop through all .tex files starting with OL_
    for %%F in ("%%D\OL_*.tex") do (
        set "filename=%%~nF"
        set "corename=!filename:OL_=!"
        
        :: Only print if it wasn't already marked as [BOTH]
        set "already_printed=0"
        if exist "%temp%\recipes.txt" (
            for /f "usebackq delims=" %%G in ("%temp%\recipes.txt") do (
                if "%%G"=="!corename!" set "already_printed=1"
            )
        )
        
        if "!already_printed!"=="0" (
            echo   [OL]   !corename!
            set "found=1"
        )
    )
    
    if "!found!"=="0" echo   (No recipes found^)
    echo.
)

if exist "%temp%\recipes.txt" del "%temp%\recipes.txt"
pause