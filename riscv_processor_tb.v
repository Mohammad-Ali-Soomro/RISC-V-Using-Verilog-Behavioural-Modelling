module riscv_processor_tb;
    // Inputs
    reg clk;
    reg reset;

    // Instantiate the RISC-V Processor
    riscv_processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;

        // Generate VCD file for waveform viewing
        $dumpfile("riscv_processor_tb.vcd");
        $dumpvars(0, riscv_processor_tb);

        // Apply reset
        #20;
        reset = 0;

        // Run the processor for some cycles
        #500;

        // Display register file contents for verification
        $display("Register file contents after execution:");
        $display("x1 = %d", uut.regfile.registers[1]);  // Should be 10
        $display("x2 = %d", uut.regfile.registers[2]);  // Should be 20
        $display("x3 = %d", uut.regfile.registers[3]);  // Should be 30
        $display("x4 = %d", uut.regfile.registers[4]);  // Should be 20
        $display("x5 = %d", uut.regfile.registers[5]);  // Should be 200
        $display("x6 = %d", uut.regfile.registers[6]);  // Should be 30
        $display("x7 = %d", uut.regfile.registers[7]);  // Should be 1

        // Display memory contents
        $display("Memory contents after execution:");
        $display("Memory[0] = %d", uut.dmem.memory[0]);  // Should be 30

        $display("Simulation completed");
        $display("To view waveforms, run: gtkwave riscv_processor_tb.vcd");
        $finish;
    end

    // Monitor for debugging
    initial begin
        $monitor("Time=%0t, PC=%h, Instruction=%h", $time, uut.pc, uut.instruction);
    end
endmodule
