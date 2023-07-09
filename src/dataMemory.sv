`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 17:54:17
// Design Name: 
// Module Name: dataMemory
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

// 16x8 bit memory component that stores the data values in it
module dataMemory(input logic clk, we, reset,
                  input logic [3:0] writeAddress,
                  input logic [7:0] writeData,
                  input logic [3:0] readAddress1, readAddress2,
                  output logic [7:0] readData1, readData2);
                  
    logic [7:0] RAM[15:0];
    
    initial begin
        for (int i = 0; i < 16; i++) begin
            RAM[i] = 0;
        end
    end
    
    always@ (posedge clk) begin
        if (we) begin
            RAM[writeAddress] <= writeData;
        end
        
        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                RAM[i] = 0;
            end
        end
    end
    
    assign readData1 = RAM[readAddress1];
    assign readData2 = RAM[readAddress2];

endmodule

module tmMemory();
     // Local Signals
    logic clk, writeEnable, clear;
    logic[3:0] writeAddress, readAddress1, readAddress2;
    logic [7:0] writeData, readData1, readData2;
    
    dataMemory test(clk, writeEnable, clear, writeAddress, writeData, readAddress1, readAddress2, readData1, readData2);
    
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end
    
    initial begin
       
        writeEnable = 1; clear = 0; readAddress1 = 2; readAddress2 = 14; writeAddress = 3; writeData = 20; #10;
        writeEnable = 1; clear = 0; readAddress1 = 3; readAddress2 = 14; writeAddress = 2; writeData = 15; #10;
        writeEnable = 1; clear = 0; readAddress1 = 2; readAddress2 = 3; writeAddress = 6; writeData = 57; #10;
        writeEnable = 0; clear = 1; readAddress1 = 2; readAddress2 = 14; writeAddress = 3; writeData = 20; #10;
        writeEnable = 1; clear = 0; readAddress1 = 2; readAddress2 = 3; writeAddress = 0; writeData = 20; #10;
        writeEnable = 0; clear = 0; readAddress1 = 2; readAddress2 = 3; writeAddress = 3; writeData = 20; #10;
        writeEnable = 0; clear = 0; readAddress1 = 2; readAddress2 = 0; writeAddress = 3; writeData = 20; #10;
        
    end
endmodule
