`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 11:05:14 PM
// Design Name: RISC V Processor Top
// Module Name: RISC_V_Processor_Top
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: The top module of the RISC-V processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_V_Processor_Top(
    input clk,
    input resetn
    );
    
    // PC wires
    wire [31:0] pc_next;
    wire [31:0] pc_current;
    wire [31:0] pc_plus_four;
    
    // Instruction Memory wires
    wire [31:0] instruction;
    
    // PC Adder wires
    wire [31:0] PC_current_plus_four;
    
    // Register file wires
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] rd_data;
    wire [4:0] rs1_address;
    wire [4:0] rs2_address;
    wire [4:0] rd_address;
    wire reg_write;
    
    //ALU wires
    wire [31:0] alu_input_1;
    wire [31:0] alu_input_2;
    wire [31:0] alu_output;
    wire [2:0] alu_operation;
    wire [31:0] alu_result;
    
    //Immediate wires
    wire [31:0]rs2_data_or_immediate;
    wire limit_immediate;
    wire [31:0] limited_immediate;
    wire [31:0] immediate;
    wire reg_or_immediate;
    
    //Data memory wires
    wire [31:0] data_write_address;
    wire [31:0] data_mem_read_data_corrected;
    wire [31:0] data_mem_read_data;
    wire [31:0] data_mem_read_address;
    wire data_mem_write;
    wire branch_possibility;
    
    //Branching wires
    wire branch_or_not;
    wire [31:0] rs1_data_or_pc;
    wire pc_or_immediate;
    
    PC PC(
        .inst_addr_in(pc_next),
        .inst_addr_out(pc_current),
        .clk(clk),
        .resetn(resetn)
    );
    
    Instruction_Memory Instruction_Memory(
        .adddress(pc_current),
        .instruction(instruction),
        .clk(clk),
        .resetn(resetn)
    );
    
    Adder_32bit PC_Adder(
        .a(pc_current),
        .b(32'h00000004),
        .result(pc_plus_four),
        .resetn(resetn)
    );
    
    Register_File Register_File(
        .rs1(rs1_address),
        .rs2(rs2_address),
        .rd(rd_address),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .write_data(rd_data),
        .write_enable(reg_write),
        .clk(clk),
        .resetn(resetn)
    );
    
    ALU_32bit ALU_32bit(
        .a(rs1_data_or_pc),
        .b(rs2_data_or_immediate),
        .result(alu_result),
        .resetn(resetn),
        .control(alu_operation)
    );
    
    Control_Unit Control_Unit(
        .instruction(instruction),
        .reg_write(reg_write),
        .rs1(rs1_address),
        .rs2(rs2_address),
        .rd(rd_address),
        .alu_op(alu_operation),
        .immediate(immediate),
        .limit_immediate(limit_immediate),
        .resetn(resetn),
        .data_mem_write(data_mem_write),
        .reg_or_immediate(reg_or_immediate),
        .rs1_data_or_pc(rs1_data_or_pc_control),
        .branch_possibility(branch_possibility)
    );
    
    Two_One_Mux Reg_or_Immediate(
        .sel(reg_or_immediate),
        .a(limited_immediate),
        .b(rs2_data),
        .out(rs2_data_or_immediate)
    );

    Immediate_Limiter Immediate_Limiter(
         .immediate_input(immediate),
         .limit(limit_immediate),
         .immediate_output(limited_immediate)
    );
    
    Data_Memory Data_Memory(
        .write_address(alu_result),
        .write_en(data_mem_write),
        .write_data(rs2_data),
        .write_command(instruction[13:12]),
        .read_data(data_mem_read_data),
        .clk(clk),
        .resetn(resetn),
        .read_address(alu_result)
    );
    
    Load_Generator Load_Generator(
        .data_input(data_mem_read_data),
        .control(instruction[14:12]),
        .data_output(data_mem_read_data_corrected),
        .resetn(resetn)
    );
    
    Two_One_Mux Alu_or_Load(
        .sel(instruction[4]),
        .a(data_mem_read_data_corrected),
        .b(alu_result),
        .out(rd_data)
    );
    
    Branch_Comparator Branch_Comparator(
        .rs1(rs1_data),
        .rs2(rs2_data),
        .branch_or_not(branch_or_not),
        .command(instruction[14:12]),
        .branch_possibility(branch_possibility)
    );
    
    Two_One_Mux PC_plus_four_or_Branch(
        .sel(branch_or_not),
        .a(pc_plus_four),
        .b(alu_result),
        .out(pc_next)
    );
    
    Two_One_Mux Rs1_or_Pc(
        .sel(rs1_data_or_pc_control),
        .a(rs1_data),
        .b(pc_current),
        .out(rs1_data_or_pc)
    );
    
endmodule
