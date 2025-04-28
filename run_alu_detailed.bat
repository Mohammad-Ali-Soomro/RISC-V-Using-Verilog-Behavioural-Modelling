@echo off
echo ===== Detailed ALU Simulation =====
echo.
echo Step 1: Compiling ALU module and test bench...
iverilog -o alu_tb alu.v alu_tb.v
if %errorlevel% neq 0 (
    echo Compilation failed with error code %errorlevel%
    pause
    exit /b %errorlevel%
)
echo Compilation successful!
echo.

echo Step 2: Running simulation...
vvp alu_tb
if %errorlevel% neq 0 (
    echo Simulation failed with error code %errorlevel%
    pause
    exit /b %errorlevel%
)
echo.

echo Step 3: Checking for VCD file...
if exist alu_tb.vcd (
    echo VCD file generated successfully: alu_tb.vcd
) else (
    echo ERROR: VCD file was not generated!
)
echo.

echo Step 4: Opening waveform in GTKWave...
echo Press any key to open GTKWave or Ctrl+C to cancel...
pause > nul
gtkwave alu_tb.vcd

echo.
echo Simulation process completed!
pause
