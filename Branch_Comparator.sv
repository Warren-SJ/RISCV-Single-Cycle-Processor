`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2025 11:21:23 PM
// Design Name: 
// Module Name: Branch_Comparator
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


module Branch_Comparator(
    input [31:0] rs1,
    input [31:0] rs2,
    output reg branch_or_not,
    input [2:0] command,
    input branch_possibility
    );
    always_comb begin
        if (branch_possibility) begin
            case(command)
                3'b000: branch_or_not <= rs1 == rs2 ? 1'b1:1'b0;
                3'b001: branch_or_not <= rs1 != rs2 ? 1'b1:1'b0;
                3'b100: branch_or_not <= $signed(rs1) < $signed(rs2) ? 1'b1:1'b0;
                3'b101: branch_or_not <= $signed(rs1) >= $signed(rs2) ? 1'b1:1'b0;
                3'b110: branch_or_not <= rs1 < rs2 ? 1'b1:1'b0;
                3'b111: branch_or_not <= rs1 >= rs2 ? 1'b1:1'b0;
                default: branch_or_not <= 1'b0; 
            endcase
        end else begin
            branch_or_not <= 1'b0;
        end
    end
endmodule
