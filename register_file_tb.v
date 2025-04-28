module register_file_tb;
    // Inputs
    reg clk;
    reg reset;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] write_data;
    reg reg_write;
    
    // Outputs
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    
    // Instantiate the Register File
    register_file uut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test vectors
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        reg_write = 0;
        
        // Apply reset
        #10;
        reset = 0;
        
        // Test writing to register 1
        #10;
        rd = 5'd1;
        write_data = 32'd100;
        reg_write = 1;
        #10;
        reg_write = 0;
        
        // Test reading from register 1
        rs1 = 5'd1;
        #10;
        if (read_data1 !== 32'd100) $display("Register read test failed: reg[%d] = %d", rs1, read_data1);
        else $display("Register read test passed: reg[%d] = %d", rs1, read_data1);
        
        // Test writing to register 2
        #10;
        rd = 5'd2;
        write_data = 32'd200;
        reg_write = 1;
        #10;
        reg_write = 0;
        
        // Test reading from register 2
        rs2 = 5'd2;
        #10;
        if (read_data2 !== 32'd200) $display("Register read test failed: reg[%d] = %d", rs2, read_data2);
        else $display("Register read test passed: reg[%d] = %d", rs2, read_data2);
        
        // Test writing to register 0 (should remain 0)
        #10;
        rd = 5'd0;
        write_data = 32'd300;
        reg_write = 1;
        #10;
        reg_write = 0;
        
        // Test reading from register 0
        rs1 = 5'd0;
        #10;
        if (read_data1 !== 32'd0) $display("Register x0 test failed: reg[0] = %d", read_data1);
        else $display("Register x0 test passed: reg[0] = %d", read_data1);
        
        $display("Register file tests completed");
        $finish;
    end
endmodule
