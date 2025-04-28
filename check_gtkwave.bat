@echo off
echo Checking GTKWave installation...
echo.

where gtkwave > nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: GTKWave not found in PATH!
    echo.
    echo Please make sure GTKWave is installed and added to your system PATH.
    echo Typical installation path: C:\Program Files\GTKWave\bin
    echo.
    echo You may need to add this path to your system PATH environment variable.
) else (
    echo GTKWave found in PATH.
    echo.
    echo Testing GTKWave version:
    gtkwave --version
)

echo.
echo Check completed!
pause
