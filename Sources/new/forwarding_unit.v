`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2021 12:07:33 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
input [4:0] ID_EX_RegisterRs1,
input [4:0] ID_EX_RegisterRs2,
input EX_MEM_RegWrite,
input [4:0] EX_MEM_RegisterRd,
input MEM_WB_RegWrite,
input [4:0] MEM_WB_RegisterRd,
output reg forwardA, forwardB
    );
    
    always @(*) begin
//        if ( (EX_MEM_RegWrite && (EX_MEM_RegisterRd != 5'b0)) && (EX_MEM_RegisterRd == ID_EX_RegisterRs1) )
//            forwardA = 2'b10;
//        else
         if ( (MEM_WB_RegWrite && (MEM_WB_RegisterRd != 5'b0)) 
                  && (MEM_WB_RegisterRd == ID_EX_RegisterRs1) )
            forwardA = 1'b1;
        else forwardA = 1'b0;
            
            
//        if ( (EX_MEM_RegWrite && (EX_MEM_RegisterRd != 5'b0)) && (EX_MEM_RegisterRd == ID_EX_RegisterRs2) )
//            forwardB = 2'b10;
//        else
         if ( (MEM_WB_RegWrite && (MEM_WB_RegisterRd != 5'b0))
                  && (MEM_WB_RegisterRd == ID_EX_RegisterRs2) )
            forwardB = 1'b1;
              else forwardB = 1'b0;
    end
    
endmodule
