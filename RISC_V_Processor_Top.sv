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
    wire [31:0] PC_next;
    wire [31:0] PC_current;
    
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
    
    //Immediate
    wire [31:0]rs2_data_or_immediate;
    
    PC PC(
        .inst_addr_in(PC_next),
        .inst_addr_out(PC_current),
        .clk(clk),
        .resetn(resetn)
    );
    
    Instruction_Memory Instruction_Memory(
        .adddress(PC_current),
        .instruction(instruction),
        .clk(clk),
        .resetn(resetn)
    );
    
    Adder_32bit PC_Adder(
        .a(PC_current),
        .b(32'h00000004),
        .result(PC_next),
        .clk(clk),
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
        .a(rs1_data),
        .b(rs2_data_or_immediate),
        .result(rd_data),
        .clk(clk),
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
        .clk(clk),
        .resetn(clk)
    );
    
    Two_One_Mux reg_or_immediate(
        .sel(instruction[5]),
        .a(immediate),
        .b(rs2_data),
        .out(rs2_data_or_immediate)
    );

    
endmodule
