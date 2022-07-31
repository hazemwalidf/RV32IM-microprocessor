// file: Nbit_RCA.v
// author: @hazemwalidf

`timescale 1ns/1ns

module Nbit_RCA #(parameter N=32)(input [N-1:0] A, B, input Cin, output [N-1:0] Sum, output Cout );
    wire [N-1:0] C;
    
    full_adder A1(A[0], B[0], Cin, Sum[0], C[0]);
    
    genvar i;
    generate
      for(i = 1; i < N; i = i+1)
      begin
        full_adder FA(A[i], B[i], C[i-1], Sum[i], C[i]);
      end
    endgenerate
    
    assign Cout = C[N-1];

endmodule