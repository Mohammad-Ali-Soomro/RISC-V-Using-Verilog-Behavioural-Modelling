@echo off
echo Running RISC-V Processor Simulations

echo.
echo ===== Simulating ALU =====
iverilog -o alu_tb alu.v alu_tb.v
vvp alu_tb
echo Waveform generated: alu_tb.vcd

echo.
echo ===== Simulating Register File =====
iverilog -o register_file_tb register_file.v register_file_tb.v
vvp register_file_tb
echo Waveform generated: register_file_tb.vcd

echo.
echo ===== Simulating Complete RISC-V Processor =====
iverilog -o riscv_processor_tb riscv_processor.v alu.v alu_control.v control_unit.v data_memory.v immediate_generator.v instruction_memory.v program_counter.v register_file.v riscv_processor_tb.v
vvp riscv_processor_tb
echo Waveform generated: riscv_processor_tb.vcd

echo.
echo All simulations completed!
echo You can view the waveforms using GTKWave:
echo gtkwave alu_tb.vcd
echo gtkwave register_file_tb.vcd
echo gtkwave riscv_processor_tb.vcd

pause
