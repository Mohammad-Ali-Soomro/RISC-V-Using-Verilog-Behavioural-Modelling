module alu_control(
    input [1:0] alu_op,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_control_out
);

    // ALU control codes
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter MUL = 4'b0010;

    always @(*) begin
        case(alu_op)
            2'b00: alu_control_out = ADD;  // Load/Store (add for address calculation)
            
            2'b01: alu_control_out = SUB;  // Branch (subtract for comparison)
            
            2'b10: begin  // R-type
                case({funct7, funct3})
                    10'b0000000_000: alu_control_out = ADD;  // ADD
                    10'b0100000_000: alu_control_out = SUB;  // SUB
                    10'b0000001_000: alu_control_out = MUL;  // MUL
                    default: alu_control_out = ADD;
                endcase
            end
            
            2'b11: begin  // I-type
                case(funct3)
                    3'b000: alu_control_out = ADD;  // ADDI
                    // SUBI doesn't exist in standard RISC-V, but we can implement it
                    3'b001: alu_control_out = SUB;  // SUBI (custom)
                    default: alu_control_out = ADD;
                endcase
            end
            
            default: alu_control_out = ADD;
        endcase
    end

endmodule
