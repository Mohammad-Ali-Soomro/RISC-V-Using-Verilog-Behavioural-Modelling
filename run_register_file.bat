@echo off
echo Simulating Register File Module
iverilog -o register_file_tb register_file.v register_file_tb.v
vvp register_file_tb
echo Waveform generated: register_file_tb.vcd
echo To view waveform, run: gtkwave register_file_tb.vcd
pause
