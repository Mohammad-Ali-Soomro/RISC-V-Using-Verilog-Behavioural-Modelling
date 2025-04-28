module control_unit(
    input [6:0] opcode,
    output reg [1:0] alu_op,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch
);

    // RISC-V opcodes
    parameter R_TYPE = 7'b0110011;  // ADD, SUB, MUL
    parameter I_TYPE = 7'b0010011;  // ADDI, SUBI
    parameter LOAD   = 7'b0000011;  // LW
    parameter STORE  = 7'b0100011;  // SW
    parameter BRANCH = 7'b1100011;  // BEQ

    always @(*) begin
        // Default values
        alu_op = 2'b00;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        branch = 1'b0;
        
        case(opcode)
            R_TYPE: begin
                alu_op = 2'b10;     // R-type operation
                reg_write = 1'b1;   // Write to register
            end
            
            I_TYPE: begin
                alu_op = 2'b11;     // I-type operation
                alu_src = 1'b1;     // Use immediate
                reg_write = 1'b1;   // Write to register
            end
            
            LOAD: begin
                alu_src = 1'b1;     // Use immediate for address calculation
                mem_to_reg = 1'b1;  // Write memory data to register
                reg_write = 1'b1;   // Write to register
                mem_read = 1'b1;    // Read from memory
            end
            
            STORE: begin
                alu_src = 1'b1;     // Use immediate for address calculation
                mem_write = 1'b1;   // Write to memory
            end
            
            BRANCH: begin
                alu_op = 2'b01;     // Branch operation (comparison)
                branch = 1'b1;      // Branch instruction
            end
            
            default: begin
                // Default values already set
            end
        endcase
    end

endmodule
