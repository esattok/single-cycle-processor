`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 23:11:02
// Design Name: 
// Module Name: adder
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


// Adder module that will be instantialized in several places in the datapath
module adder(input logic [7:0] firstData, secondData,
             output logic [7:0] dataOut);
             
    assign dataOut = firstData + secondData;
             
endmodule
