@echo off
echo Simulating ALU Module
iverilog -o alu_tb alu.v alu_tb.v
vvp alu_tb
echo Waveform generated: alu_tb.vcd
echo To view waveform, run: gtkwave alu_tb.vcd
pause
