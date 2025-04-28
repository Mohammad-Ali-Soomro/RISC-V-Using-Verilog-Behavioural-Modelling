module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output zero
);

    // ALU control codes
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter MUL = 4'b0010;
    // We can add more operations if needed

    always @(*) begin
        case(alu_control)
            ADD: result = a + b;
            SUB: result = a - b;
            MUL: result = a * b;
            default: result = 32'b0;
        endcase
    end

    // Zero flag is set when result is 0 (used for branch instructions)
    assign zero = (result == 32'b0);

endmodule
