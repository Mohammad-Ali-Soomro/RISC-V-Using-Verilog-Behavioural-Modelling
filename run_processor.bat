@echo off
echo Simulating Complete RISC-V Processor
iverilog -o riscv_processor_tb riscv_processor.v alu.v alu_control.v control_unit.v data_memory.v immediate_generator.v instruction_memory.v program_counter.v register_file.v riscv_processor_tb.v
vvp riscv_processor_tb
echo Waveform generated: riscv_processor_tb.vcd
echo To view waveform, run: gtkwave riscv_processor_tb.vcd
pause
