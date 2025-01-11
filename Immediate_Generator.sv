`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 11:12:08 PM
// Design Name: 
// Module Name: Immediate_Generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Immediate_Generator(
    input [24:0] immediate_region,
    input [4:0] instruction,
    output reg [31:0] immediate
    );
    always @(*)
        case(instruction)
            4'b00100: immediate <= {{20{immediate_region[24]}}, immediate_region[24:13]};
            default: immediate <= 32'h00000000;
        endcase
endmodule
