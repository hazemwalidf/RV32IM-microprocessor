`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 01:30:40 PM
// Design Name: 
// Module Name: RISCV_tb
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


module RISCV_tb;

    reg [1:0] LEDSel;
    reg [3:0] SSDSel;
    reg rst;
    reg clk;
    reg SSD_clk;
    wire [15:0] LED_out;
    wire [12:0] SSD_out;
    
    RISCV_pipelined processor(LEDSel, SSDSel, rst, clk, SSD_clk, LED_out, SSD_out);
    
    initial begin
        clk=0;
        forever begin
          #5;
          clk = ~clk;
        end
    end
    
    initial begin
        rst = 1'b1;
        #5
        rst = 0;
        
        LEDSel = 2'b10;
        SSDSel = 4'b0101;
        
    end
    
endmodule
