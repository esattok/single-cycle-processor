`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 19:38:20
// Design Name: 
// Module Name: ALU
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


// ALU will choose between addition and comparison according to the select signal
module ALU(input logic [7:0] firstData, secondData,
           input logic select,
           output logic [7:0] dataOut);
           
    // Instantiating the signal
    logic comperatorOutput;
    logic [7:0] adderOutput;
               
    // Instantiating the adder
    adder addition(firstData, secondData, adderOutput);
    
    // Instantiating the comperator
    comperator comperation(firstData, secondData, comperatorOutput);
    
    
    always_comb begin
        case (select)
            1'b0: dataOut = adderOutput;
            1'b1: dataOut = comperatorOutput;
        endcase
    end

endmodule
