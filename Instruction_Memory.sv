`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 10:59:52 PM
// Design Name: Instruction Memory
// Module Name: Instruction_Memory
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Instruction memory for the processor. Byte addressable. 1024 bytes can be stored
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [31:0] adddress,
    output reg [31:0] instruction,
    input clk,
    input resetn
    );
    
    reg [7:0] memory [1023:0];
    
    always_ff @ (posedge clk) begin
        if (!resetn) begin
            instruction  <= 32'h00000000;
            for (integer  i = 0; i < 1024; i = i + 1) begin
                memory[i] = 8'h00;
            end
        end else begin
            instruction[7:0] <= memory[adddress + 0];
            instruction[15:8] <= memory[adddress + 1];
            instruction[23:16] <= memory[adddress + 2];
            instruction[31:24] <= memory[adddress + 3];
        end
    end
endmodule
