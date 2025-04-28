module immediate_generator(
    input [31:0] instruction,
    output reg [31:0] immediate
);

    // Instruction types
    wire [6:0] opcode = instruction[6:0];
    
    // RISC-V opcodes
    parameter I_TYPE = 7'b0010011;  // ADDI, SUBI
    parameter LOAD   = 7'b0000011;  // LW
    parameter STORE  = 7'b0100011;  // SW
    parameter BRANCH = 7'b1100011;  // BEQ

    always @(*) begin
        case(opcode)
            I_TYPE, LOAD: begin
                // I-type immediate: sign-extended 12-bit immediate
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            end
            
            STORE: begin
                // S-type immediate: sign-extended 12-bit immediate (split fields)
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            
            BRANCH: begin
                // B-type immediate: sign-extended 13-bit immediate (split fields, LSB=0)
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7], 
                             instruction[30:25], instruction[11:8], 1'b0};
            end
            
            default: immediate = 32'b0;
        endcase
    end

endmodule
