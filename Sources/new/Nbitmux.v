// file: Nbit_MUX.v
// author: @hazemwalidf

`timescale 1ns/1ns

module Nbit2x1_MUX #(parameter N=32)(input [N-1:0] A, B, input S, output reg [N-1:0] C);

always @(*)
begin
if(S==1)
C=B;
else
C=A;

end
endmodule