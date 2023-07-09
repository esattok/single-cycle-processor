`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 23:18:24
// Design Name: 
// Module Name: comperator
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


// Compares the input datas and output 1 if they are equal
module comperator(input logic [7:0] firstData, secondData,
                  output logic isEqual);
                  
    assign isEqual = firstData == secondData;
                  
endmodule
