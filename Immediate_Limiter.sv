`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 09:27:27 AM
// Design Name: Immediate Limiter
// Module Name: Immediate_Limiter
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Decides whether to limit the immediate or not
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Immediate_Limiter(
    input [31:0] immediate_input,
    input limit,
    output reg [31:0] immediate_output
    );
    always @(*) begin
        if (limit)
            immediate_output <= {{27'b0}, immediate_input [4:0]};
        else
            immediate_output <= immediate_input;
    end
endmodule
