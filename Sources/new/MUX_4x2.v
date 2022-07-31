`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2021 12:54:15 PM
// Design Name: 
// Module Name: MUX_4x2
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


module MUX_4x2(
input [31:0] A, B, C, D,
input [1:0] Sel,
output reg [31:0] Out
    );
    
    always @(*) begin
        case(Sel)
            2'b00: Out = A;
            2'b01: Out = B;
            2'b10: Out = C;
            2'b11: Out = D;
        endcase
    end
    
    
    
endmodule
