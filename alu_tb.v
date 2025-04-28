module alu_tb;
    // Inputs
    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] alu_control;

    // Outputs
    wire [31:0] result;
    wire zero;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    // Test vectors
    initial begin
        // Initialize inputs
        a = 0;
        b = 0;
        alu_control = 0;

        // Generate VCD file for waveform viewing
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Wait for global reset
        #100;

        // Test ADD operation
        a = 32'd10;
        b = 32'd20;
        alu_control = 4'b0000;  // ADD
        #10;
        if (result !== 32'd30) $display("ADD test failed: %d + %d = %d", a, b, result);
        else $display("ADD test passed: %d + %d = %d", a, b, result);

        // Test SUB operation
        a = 32'd30;
        b = 32'd10;
        alu_control = 4'b0001;  // SUB
        #10;
        if (result !== 32'd20) $display("SUB test failed: %d - %d = %d", a, b, result);
        else $display("SUB test passed: %d - %d = %d", a, b, result);

        // Test MUL operation
        a = 32'd10;
        b = 32'd20;
        alu_control = 4'b0010;  // MUL
        #10;
        if (result !== 32'd200) $display("MUL test failed: %d * %d = %d", a, b, result);
        else $display("MUL test passed: %d * %d = %d", a, b, result);

        // Test zero flag
        a = 32'd10;
        b = 32'd10;
        alu_control = 4'b0001;  // SUB
        #10;
        if (zero !== 1'b1) $display("Zero flag test failed");
        else $display("Zero flag test passed");

        $display("ALU tests completed");
        $display("To view waveforms, run: gtkwave alu_tb.vcd");
        $finish;
    end
endmodule
