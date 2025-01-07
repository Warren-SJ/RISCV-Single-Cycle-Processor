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
    
    //ALU wires
    wire [31:0] alu_input_1;
    wire [31:0] alu_input_2;
    wire [31:0] alu_output;
    
    PC PC(
        .inst_addr_in(PC_current),
        .inst_addr_out(PC_next),
        .clk(clk),
        .resetn(resetn)
    );
    Instruction_Memory Instruction_Memory(
        .adddress(PC_next),
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
        .rs1(),
        .rs2(),
        .rd(),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .write_data(),
        .clk(clk),
        .resetn(resetn)
    );
    
    ALU_32bit ALU_32bit(
        .a(alu_input_1),
        .b(alu_input_2),
        .result(alu_output),
        .clk(clk),
        .resetn(reset_n),
        .control()
    );
    
    assign rs1_data = alu_input_1;
    assign rs2_data = alu_input_2;
endmodule
