@echo off
echo RISC-V Processor Waveform Viewer
echo.
echo 1. View ALU Waveform
echo 2. View Register File Waveform
echo 3. View Complete Processor Waveform
echo.
set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" (
    gtkwave alu_tb.vcd
) else if "%choice%"=="2" (
    gtkwave register_file_tb.vcd
) else if "%choice%"=="3" (
    gtkwave riscv_processor_tb.vcd
) else (
    echo Invalid choice!
)
pause
