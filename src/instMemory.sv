`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 18:14:06
// Design Name: 
// Module Name: instMemory
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


// Read only instruction memory that outputs the instruction corresponds to the input address
module instMemory(input logic [4:0] address,
                  output logic [15:0] instruction);
                  
    always_comb begin
        case (address)
            // Up to 32 instructions can be added to the read only instruction memory
            5'b00000: instruction = 16'b001_0_0000_0000_0000;
            5'b00001: instruction = 16'b001_0_0000_0001_0001;
            5'b00010: instruction = 16'b001_1_0010_00000000;
            5'b00011: instruction = 16'b001_1_0011_00000000;
            5'b00100: instruction = 16'b001_1_0100_00000001;
            5'b00101: instruction = 16'b101_01001_0010_0001;
            5'b00110: instruction = 16'b010_0_0011_0011_0000;
            5'b00111: instruction = 16'b010_0_0010_0010_0100;
            5'b01000: instruction = 16'b101_00101_0000_0000;
            5'b01001: instruction = 16'b000_0_0000_0011_0011;
        endcase 
    end
                  
endmodule
