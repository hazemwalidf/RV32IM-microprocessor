`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2021 12:20:54 PM
// Design Name: 
// Module Name: board
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


module board(
input [1:0] LEDSel,
input [3:0] SSDSel,
input rst,
input clk,
input SSD_clk,
output [6:0] display,
output [3:0] Anode,
output [15:0] LED_out
    );
 wire [12:0] SSD_out;
 
 RISCV_pipelined pipelined(LEDSel, SSDSel, rst, clk, SSD_clk, LED_out, SSD_out);
 Four_Digit_Seven_Segment_Driver SSD(SSD_clk, SSD_out, Anode, display);
   
endmodule
