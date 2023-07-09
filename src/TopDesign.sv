`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2020 23:29:01
// Design Name: 
// Module Name: TopDesign
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


module TopDesign(input logic clk, btnU, btnC, btnD, btnL, btnR,
                 input logic [15:0] instruction,
                 output logic [15:0] led,
                 output [6:0] seg, logic dp,
                 output [3:0] an);
                 
     // Defining debounced button signals
    logic buttonCenter, buttonUp, buttonDown, buttonLeft, buttonRight;
    debouncer bounce1(clk, btnC, buttonCenter);
    debouncer bounce2(clk, btnU, buttonUp);
    debouncer bounce3(clk, btnD, buttonDown);
    debouncer bounce4(clk, btnL, buttonLeft);
    debouncer bounce5(clk, btnR, buttonRight);
    
                 
    // Defining the states
    typedef enum logic [4:0] {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17} statetype;
    statetype state = s0, nextstate = s0;
    
   
    // Defining signals
    logic weDataMem, clrDataMem;
    logic [3:0] wAdrDataMem, rAdrDataMem1, rAdrDataMem2;
    logic [7:0] wDataDataMem, rDataDataMem1, rDataDataMem2;
    
    logic weRegFile, clrRegFile;
    logic [3:0] wAdrRegFile, rAdrRegFile1, rAdrRegFile2;
    logic [7:0] wDataRegFile, rDataRegFile1, rDataRegFile2;
    
    logic [4:0] instAdr;
    logic [15:0] nextInstReg;
    logic [15:0] instReg;
    
    
    logic [7:0] firstDataALU, secondDataALU, dataOutALU;
    logic selectALU; // Select Input for the ALU
    
    assign led = nextInstReg; // Leds will display the next instruction in the memory to be execuded
    
    
    
    
    // Data memory
    dataMemory dataMem(clk, weDataMem, clrDataMem, wAdrDataMem, wDataDataMem, rAdrDataMem1, rAdrDataMem2, rDataDataMem1, rDataDataMem2);
    
    // Register File
    registerFile RF(clk, weRegFile, clrRegFile, wAdrRegFile, wDataRegFile, rAdrRegFile1, rAdrRegFile2, rDataRegFile1, rDataRegFile2);
    
    // Instruction Memory
    instMemory instMem(instAdr, nextInstReg);
    
    // Seven segment display
    sevenSegment sevSeg(clk, rAdrDataMem1, x, rDataDataMem1[7:4], rDataDataMem2[3:0], seg, dp, an);
    
    // Arithmetic Logic Unit
    ALU alu(firstDataALU, secondDataALU, selectALU, dataOutALU);

    // State transitions
    always_ff @(posedge clk) begin
        state <= nextstate;
    end
    
    // Next State Logic
    always_comb
        case (state)
            s0: begin
//                clrDataMem = 1;
//                clrRegFile = 1;
                instAdr = 0;
                rAdrDataMem1 = 0;
                $display("S0 içiindesin");
                
                nextstate = s1;
            end
            s1: begin
//                clrDataMem <= 0;
//                clrRegFile <= 0;

                $display("S1 içindesin");
                $display("buttonRight %b", buttonRight);
                $display("buttonLeft %b", buttonLeft);
                $display("buttonCenter %b", buttonCenter);
                $display("buttonDown %b", buttonDown);
                $display("buttonUp %b", buttonUp);
                
                if (buttonUp == 1'b1) begin
                    nextstate = s0;
                    $display("S1 buttonUp");
                end
                    
                else if (buttonLeft == 1'b1) begin
                    nextstate = s2;
                     $display("S1 buttonLeft");
                 end
                else if (buttonRight == 1'b1) begin
                    nextstate = s3;
                    $display("S1 buttonRight");
                end
                else if (buttonDown == 1'b1) begin
                    nextstate = s4;
                    $display("S1 buttonDown");
                end
                else if (buttonCenter == 1'b1) begin
                    nextstate = s6;
                    $display("S1 buttonCenter");
                end
                else begin
                    nextstate = s1;
                    $display("Elsee");
                end
            end
            s2: begin
                rAdrDataMem1 = rAdrDataMem1 - 1;
                 $display("S2 içindesin %b", rAdrDataMem1);
            
                nextstate = s1;
            end
            s3: begin
                rAdrDataMem1 = rAdrDataMem1 + 1;                
                $display("S3 içindesin %b", rAdrDataMem1);
            
                nextstate = s1;
            end
            s4: begin
                instReg = nextInstReg;
            
                nextstate = s5;
                
                $display("S4 içindesin");
            end
            s5: begin
                instAdr++;
                
                nextstate = s7;
                
                $display("S5 içindesin");
            end
            s6: begin
                instReg = instruction;
                
                nextstate = s7;  
            end
            s7: begin
                if (instReg[15:13] == 3'b000)
                    nextstate = s8;
                else if (instReg[15:13] == 3'b001)
                    nextstate = s11;
                else if (instReg[15:13] == 3'b010)
                    nextstate = s14;
                else if (instReg[15:13] == 3'b101)
                    nextstate = s15;
                else if (instReg[15:13] == 3'b111)
                    nextstate = s17;
                else
                    nextstate = s1;
            end
            s8: begin
                if (instReg[12] == 1'b1)
                    nextstate = s9;
                else if (instReg[12] == 1'b0)
                    nextstate = s10;
            end
            s9: begin
                weDataMem = 1;
                wAdrDataMem = instReg[11:8];
                wDataDataMem = instReg[7:0];
                
                nextstate = s1;
            end
            s10: begin
                weDataMem = 1;
                wAdrDataMem = instReg[7:4];
                rAdrRegFile1 = instReg[3:0];
                wDataDataMem = rDataRegFile1;
                
                nextstate = s1;
            end
            s11: begin
                if (instReg[12] == 1'b1)
                    nextstate = s12;
                else if (instReg[12] == 1'b0)
                    nextstate = s13;
            end
            s12: begin
                weRegFile = 1;
                wAdrRegFile = instReg[11:8];
                wDataRegFile = instReg[7:0];
                
                nextstate = s1;
            end
            s13: begin
                weRegFile = 1;
                wAdrRegFile = instReg[7:4];
                rAdrDataMem2 = instReg[3:0];
                wDataRegFile = rDataDataMem2;
                
                nextstate = s1;
            end
            s14: begin
                weRegFile = 1;
                selectALU = 1'b0;
                wAdrRegFile = instReg[11:8];
                rAdrRegFile1 = instReg[7:4];
                rAdrRegFile2 = instReg[3:0];
                firstDataALU = rDataRegFile1;
                secondDataALU = rDataRegFile2;
                wDataRegFile = dataOutALU;
                
                nextstate = s1;
            end
            s15: begin
                selectALU = 1'b1;
                rAdrRegFile1 = instReg[7:4];
                rAdrRegFile2 = instReg[3:0];
                
                firstDataALU = rDataRegFile1;
                secondDataALU = rDataRegFile2;
                
                if (dataOutALU == 1)
                    nextstate = s16;
                else 
                    nextstate = s1;
            end
            s16: begin
                instAdr = instReg[12:8];
                nextstate = s1;
            end
            s17: begin
                if (buttonUp)
                    nextstate = s0;
                else 
                    nextstate = s17; 
            end
            default: nextstate = s1;
        endcase
        
        
        
    
endmodule

module tb();
    // Signals
    logic clk, btnU, btnD, btnR, btnL, btnC;
    logic [15:0] inst;
    logic [15:0] led;
    logic [6:0] seg;
    logic dp;
    logic [3:0] an;
    
    TopDesign dut(clk, btnU, btnC, btnD, btnL, btnR, inst, led, seg, dp, an);
    
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end
    
    initial begin
//        btnD = 1; #10;
//        btnD = 1; #10;
//        btnL = 1; #10;
//        btnL = 1; #10;
//        btnL = 0; #10;
//        btnR = 1; #10;
          
         
          btnR = 1; $display(btnR); #10;
          
          //btnR = 0; #10;
         // btnR = 1;
         
          
          #30;
          btnR = 1; #10;
          btnC = 1; #10;
          btnC = 1; #10;
          
//        btnR = 1; #10;
//        btnR = 1; #10;
//        btnL = 1; #10;
//        btnC = 1; #10;
//        btnU = 1; #10;
    
    end
endmodule
