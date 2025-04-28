# RISC-V Processor Simulation Script for PowerShell

Write-Host "Running RISC-V Processor Simulations" -ForegroundColor Green
Write-Host ""

# Function to run a simulation
function Run-Simulation {
    param (
        [string]$Name,
        [string]$OutputFile,
        [string]$VcdFile,
        [string[]]$SourceFiles
    )
    
    Write-Host "===== Simulating $Name =====" -ForegroundColor Cyan
    
    # Compile the source files
    Write-Host "Compiling..." -ForegroundColor Yellow
    $compileArgs = "-o", $OutputFile
    $compileArgs += $SourceFiles
    & iverilog $compileArgs
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Compilation failed with error code $LASTEXITCODE" -ForegroundColor Red
        return $false
    }
    
    # Run the simulation
    Write-Host "Running simulation..." -ForegroundColor Yellow
    & vvp $OutputFile
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Simulation failed with error code $LASTEXITCODE" -ForegroundColor Red
        return $false
    }
    
    # Check if VCD file was generated
    if (Test-Path $VcdFile) {
        Write-Host "Waveform generated: $VcdFile" -ForegroundColor Green
    } else {
        Write-Host "WARNING: VCD file was not generated!" -ForegroundColor Yellow
    }
    
    Write-Host ""
    return $true
}

# Simulate ALU
$aluSuccess = Run-Simulation -Name "ALU" -OutputFile "alu_tb" -VcdFile "alu_tb.vcd" -SourceFiles @("alu.v", "alu_tb.v")

# Simulate Register File
$regSuccess = Run-Simulation -Name "Register File" -OutputFile "register_file_tb" -VcdFile "register_file_tb.vcd" -SourceFiles @("register_file.v", "register_file_tb.v")

# Simulate Complete Processor
$procSuccess = Run-Simulation -Name "Complete RISC-V Processor" -OutputFile "riscv_processor_tb" -VcdFile "riscv_processor_tb.vcd" -SourceFiles @(
    "riscv_processor.v", "alu.v", "alu_control.v", "control_unit.v", 
    "data_memory.v", "immediate_generator.v", "instruction_memory.v", 
    "program_counter.v", "register_file.v", "riscv_processor_tb.v"
)

Write-Host "All simulations completed!" -ForegroundColor Green
Write-Host ""

# Check GTKWave installation
Write-Host "Checking GTKWave installation..." -ForegroundColor Yellow
try {
    $gtkwaveVersion = & gtkwave --version 2>&1
    Write-Host "GTKWave is installed: $gtkwaveVersion" -ForegroundColor Green
    
    # Ask user which waveform to view
    Write-Host ""
    Write-Host "Which waveform would you like to view?" -ForegroundColor Cyan
    Write-Host "1. ALU Waveform"
    Write-Host "2. Register File Waveform"
    Write-Host "3. Complete Processor Waveform"
    Write-Host "4. None (Exit)"
    
    $choice = Read-Host "Enter your choice (1-4)"
    
    switch ($choice) {
        "1" { & gtkwave alu_tb.vcd }
        "2" { & gtkwave register_file_tb.vcd }
        "3" { & gtkwave riscv_processor_tb.vcd }
        "4" { Write-Host "Exiting without viewing waveforms." -ForegroundColor Yellow }
        default { Write-Host "Invalid choice. Exiting." -ForegroundColor Red }
    }
} catch {
    Write-Host "ERROR: GTKWave not found or not working properly!" -ForegroundColor Red
    Write-Host "Please make sure GTKWave is installed and added to your system PATH." -ForegroundColor Yellow
    Write-Host "Typical installation path: C:\Program Files\GTKWave\bin" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
