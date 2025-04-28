module register_file(
    input clk,
    input reset,
    input [4:0] rs1,          // Source register 1
    input [4:0] rs2,          // Source register 2
    input [4:0] rd,           // Destination register
    input [31:0] write_data,  // Data to write
    input reg_write,          // Register write enable
    output [31:0] read_data1, // Data from source register 1
    output [31:0] read_data2  // Data from source register 2
);

    // 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];
    integer i;

    // Initialize registers to 0 on reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (reg_write && rd != 5'b0) begin
            // Register x0 is hardwired to 0 in RISC-V
            registers[rd] <= write_data;
        end
    end

    // Read data from registers
    // Register x0 is hardwired to 0
    assign read_data1 = (rs1 == 5'b0) ? 32'b0 : registers[rs1];
    assign read_data2 = (rs2 == 5'b0) ? 32'b0 : registers[rs2];

endmodule
