`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2025 11:06:00 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [31:0] instruction,
    output reg reg_write,
    output reg [2:0] alu_op,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] immediate,
    output reg limit_immediate,
    output reg data_mem_write,
    input resetn
    );

    reg [2:0] func3;
    reg [6:0] func7;
    reg [6:0] opcode;
    
    Instruction_Parser Instruction_Parser(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func3(func3),
        .func7(func7),
        .opcode(opcode)
    );
    
    Immediate_Generator Immediate_Generator(
        .immediate_region(instruction[31:7]),
        .instruction(instruction[6:2]),
        .immediate(immediate)
    );
    
    always @ (*) begin
        if (!resetn) begin
            reg_write  <= 1'b0;
        end else begin
            case (opcode)
                 7'b0110011: begin
                     reg_write <= 1'b1;
                    case (func3)
                        3'b000: if (func7 == 7'b0000000)
                                    alu_op <= 3'b000;
                                else if (func7 == 7'b0010100)
                                    alu_op <= 3'b001;
                        3'b100: alu_op <= 3'b010;
                        3'b110: alu_op <= 3'b011;
                        3'b111: alu_op <= 3'b100;
                        3'b001: alu_op <= 3'b101;
                        3'b101: alu_op <= 3'b110;
                        3'b010: alu_op <= 3'b111;
                        3'b011: alu_op <= 3'b111;
                        default: alu_op <= 3'b000;
                    endcase
                  end
                  7'b0010011: begin
                    reg_write <= 1'b1;
                    case(func3)
                        3'b000: alu_op <= 3'b000;
                        3'b100: alu_op <= 3'b010;
                        3'b110: alu_op <= 3'b011;
                        3'b111: alu_op <= 3'b100;
                        3'b001: alu_op <= 3'b101;
                        3'b101: alu_op <= 3'b110;
                        3'b010: alu_op <= 3'b111;
                        3'b011: alu_op <= 3'b111;
                        default: alu_op <= 3'b000;
                    endcase
                  end
                  7'b0000011: begin
                    reg_write <= 1'b1;
                    alu_op <= 3'b000;
                  end
                  default: begin
                               reg_write <=1'b0;
                               alu_op <= 3'b000;
                           end
             endcase
        end
    end
    
    always @ (*) begin
        if (!resetn) begin
            limit_immediate  <= 1'b0;
        end else begin
            case (opcode)
                7'b0010011: begin
                    case (func3)
                        3'b001: limit_immediate <= 1'b1;
                        3'b101: limit_immediate <= 1'b1;
                        default: limit_immediate <= 1'b0;
                     endcase
                 end
                 default: limit_immediate <= 1'b0;
             endcase
          end
      end
endmodule
