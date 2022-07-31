`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 11:50:40 AM
// Design Name: 
// Module Name: full_addder
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


module full_adder(
input A, B, Cin,
output Sum,
output Cout
    );
    
    assign Sum = A^B^Cin;
    assign Cout = ((A&B)|(B&Cin)|(A&Cin));
   
endmodule
