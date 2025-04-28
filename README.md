# RISC-V Processor Implementation

This project implements a simplified RISC-V processor using Verilog behavioral modeling. The processor supports a subset of the RISC-V instruction set, including arithmetic, memory, and branch operations.

## Supported Instructions

- ADD (Addition)
- SUB (Subtraction)
- MUL (Multiplication)
- ADDI (Add Immediate)
- SUBI (Subtract Immediate - custom instruction)
- LW (Load Word)
- SW (Store Word)
- BEQ (Branch if Equal)

## Project Structure

- `alu.v`: Arithmetic Logic Unit implementation
- `alu_control.v`: ALU control signal generator
- `alu_tb.v`: Test bench for ALU
- `control_unit.v`: Main control unit for the processor
- `data_memory.v`: Data memory implementation
- `immediate_generator.v`: Immediate value generator for different instruction types
- `instruction_memory.v`: Instruction memory implementation
- `program.mem`: Sample program in machine code
- `program_counter.v`: Program counter implementation
- `register_file.v`: Register file with 32 registers
- `register_file_tb.v`: Test bench for register file
- `riscv_processor.v`: Top-level processor module
- `riscv_processor_tb.v`: Test bench for the complete processor

## How to Run

1. Compile all Verilog files using your preferred simulator (e.g., ModelSim, Icarus Verilog)
2. Run the test benches to verify individual modules:
   - `alu_tb.v`: Tests the ALU functionality
   - `register_file_tb.v`: Tests the register file functionality
   - `riscv_processor_tb.v`: Tests the complete processor with a sample program

### Example using Icarus Verilog

```bash
# Compile and run ALU test bench
iverilog -o alu_tb alu.v alu_tb.v
vvp alu_tb

# Compile and run register file test bench
iverilog -o register_file_tb register_file.v register_file_tb.v
vvp register_file_tb

# Compile and run processor test bench
iverilog -o riscv_processor_tb *.v
vvp riscv_processor_tb
```

## Sample Program

The `program.mem` file contains a sample RISC-V program that:
1. Loads immediate values into registers
2. Performs arithmetic operations
3. Stores and loads values from memory
4. Tests branch instructions

The test bench `riscv_processor_tb.v` runs this program and displays the final register and memory values for verification.

## Notes

- This implementation uses a simplified memory model with limited address space
- The processor implements a subset of the RISC-V instruction set
- The design uses behavioral modeling rather than gate-level or structural modeling
