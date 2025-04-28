module data_memory(
    input clk,
    input [31:0] address,
    input [31:0] write_data,
    input mem_write,
    input mem_read,
    output reg [31:0] read_data
);

    // Memory with 256 32-bit words
    reg [31:0] memory [0:255];
    
    // Initialize memory with zeros
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'b0;
        end
    end
    
    // Write to memory
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[9:2]] <= write_data;
        end
    end
    
    // Read from memory
    always @(*) begin
        if (mem_read) begin
            read_data = memory[address[9:2]];
        end
        else begin
            read_data = 32'b0;
        end
    end

endmodule
