`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2025 11:18:06 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input [31:0] write_address,
    input write_en,
    input [31:0] write_data,
    output reg [31:0] read_data,
    input clk,
    input resetn,
    input [31:0] read_address
    );
    
    reg [7:0] memory [1023:0];
    
    initial begin
        memory[0] = 8'b10101010;
        memory[1] = 8'b10000001;
        memory[2] = 8'b00001111;
        memory[3] = 8'b11110000;
        memory[4] = 8'b00110011;
        memory[5] = 8'b11001100;
        memory[6] = 8'b10000010;
        memory[7] = 8'b00101010;
    end
    always_ff @ (posedge clk) begin
        if (!resetn) begin
            for (integer  i = 0; i < 1024; i = i + 1) begin
                memory[i] = 8'h00;
            end
        end else begin
            if (write_en) begin
                memory[write_address + 0] <= write_data[7:0];
                memory[write_address + 1] <= write_data[15:8];
                memory[write_address + 2] <= write_data[23:16];
                memory[write_address + 3] <= write_data[31:24];
            end  
        end
    end
    
    always_comb @(read_address) begin
        if (!resetn) begin
            read_data  <= 32'h00000000;
        end
        read_data[7:0] <= memory[read_address + 0];
        read_data[15:8] <= memory[read_address + 1];
        read_data[23:16] <= memory[read_address + 2];
        read_data[31:24] <= memory[read_address + 3];    
    end
    
endmodule
