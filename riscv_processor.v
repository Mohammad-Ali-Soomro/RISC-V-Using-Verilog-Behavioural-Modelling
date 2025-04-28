module riscv_processor(
    input clk,
    input reset
);

    // Wires for connecting modules
    wire [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] pc_plus_4;
    wire [31:0] instruction;
    wire [31:0] immediate;
    wire [31:0] alu_result;
    wire [31:0] read_data1, read_data2;
    wire [31:0] alu_operand2;
    wire [31:0] write_data;
    wire [31:0] read_data_mem;
    wire [31:0] branch_target;
    wire zero;
    wire branch_taken;
    
    // Control signals
    wire [1:0] alu_op;
    wire alu_src;
    wire mem_to_reg;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire [3:0] alu_control_out;
    
    // Instruction fields
    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    wire [6:0] funct7 = instruction[31:25];
    
    // PC calculation
    assign pc_plus_4 = pc + 4;
    assign branch_target = pc + immediate;
    assign branch_taken = branch & zero;
    assign next_pc = branch_taken ? branch_target : pc_plus_4;
    
    // ALU operand selection
    assign alu_operand2 = alu_src ? immediate : read_data2;
    
    // Write data selection
    assign write_data = mem_to_reg ? read_data_mem : alu_result;
    
    // Module instantiations
    program_counter pc_module(
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );
    
    instruction_memory imem(
        .address(pc),
        .instruction(instruction)
    );
    
    control_unit control(
        .opcode(opcode),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch)
    );
    
    register_file regfile(
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
    
    immediate_generator imm_gen(
        .instruction(instruction),
        .immediate(immediate)
    );
    
    alu_control alu_ctrl(
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control_out(alu_control_out)
    );
    
    alu alu_module(
        .a(read_data1),
        .b(alu_operand2),
        .alu_control(alu_control_out),
        .result(alu_result),
        .zero(zero)
    );
    
    data_memory dmem(
        .clk(clk),
        .address(alu_result),
        .write_data(read_data2),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(read_data_mem)
    );

endmodule
