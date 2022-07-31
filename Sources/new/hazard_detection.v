`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2021 01:43:39 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
input [4:0] IF_ID_RegisterRs1, IF_ID_RegisterRs2,
input [4:0] ID_EX_RegisterRd,
input ID_EX_MemRead,
output reg stall
    );
    
    always @(*) begin
    
        if ( ((IF_ID_RegisterRs1 == ID_EX_RegisterRd) || (IF_ID_RegisterRs2 == ID_EX_RegisterRd)) 
        && ID_EX_MemRead && (ID_EX_RegisterRd != 5'b0) )
            stall = 1'b1;
        else stall = 1'b0;
    
    end
    
    
    
    
    
endmodule
