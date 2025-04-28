module instruction_memory(
    input [31:0] address,
    output [31:0] instruction
);

    // Memory with 256 32-bit words
    reg [31:0] memory [0:255];
    
    // Initialize memory with a test program
    initial begin
        // Memory is initialized with zeros by default
        // Test program will be loaded in the testbench
        $readmemh("program.mem", memory);
    end
    
    // Read instruction from memory
    // Address is word-aligned (ignore lowest 2 bits)
    assign instruction = memory[address[9:2]];

endmodule
