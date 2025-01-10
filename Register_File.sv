`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2025 11:46:20 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    output reg [31:0] rs1_data,
    output reg [31:0] rs2_data,
    input [31:0] write_data,
    input write_enable,
    input clk,
    input resetn
    );
    
    reg [31:0] registers [31:0];
    initial begin
        registers[0] = 32'h00000000;
        registers[1] = 32'h00000008;
    end
    always_ff @ (posedge clk) begin
        if (!resetn) begin
            rs1_data  <= 32'h00000000;
            rs2_data  <= 32'h00000000;
        end else begin
            rs1_data <= registers[rs1];
            rs2_data <= registers[rs2];
            if (write_enable) begin
                if (rd != 32'h00000000) begin
                    registers[rd] <= write_data;
                end
            end
        end
    end
endmodule
