`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 10:59:52 PM
// Design Name: Hexadecimal Decoder
// Module Name: hex_decoder
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Decodes a 4-bit binary input to a 7-segment output
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module hex_decoder (
    input  [3:0] bin,  // 4-bit binary input
    output reg [6:0] seg // 7-segment output
);
    always @(*) begin
        case (bin)
            4'h0: seg = 7'b100_0000;
            4'h1: seg = 7'b111_1001;
            4'h2: seg = 7'b010_0100;
            4'h3: seg = 7'b011_0000;
            4'h4: seg = 7'b001_1001;
            4'h5: seg = 7'b001_0010;
            4'h6: seg = 7'b000_0010;
            4'h7: seg = 7'b111_1000;
            4'h8: seg = 7'b000_0000;
            4'h9: seg = 7'b001_0000;
            4'hA: seg = 7'b000_1000;
            4'hB: seg = 7'b000_0011;
            4'hC: seg = 7'b100_0110;
            4'hD: seg = 7'b010_0001;
            4'hE: seg = 7'b000_0110;
            4'hF: seg = 7'b000_1110;
            default: seg = 7'b111_1111; // All segments off
        endcase
    end
endmodule
