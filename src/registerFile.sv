`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 17:52:14
// Design Name: 
// Module Name: registerFile
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


module registerFile(input logic clk, we, reset,
                    input logic [3:0] writeAddress,
                    input logic [7:0] writeData,
                    input logic [3:0] readAddress1, readAddress2,
                    output logic [7:0] readData1, readData2);
                    
    logic [7:0] RF[15:0];
    
    initial begin
        for (int i = 0; i < 16; i++) begin
            RF[i] = 0;
        end
    end
    
    always@ (posedge clk) begin
        if (we) begin
            RF[writeAddress] <= writeData;
        end
        
        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                RF[i] = 0;
            end
        end
    end
    
    assign readData1 = RF[readAddress1];
    assign readData2 = RF[readAddress2];
                    
endmodule
