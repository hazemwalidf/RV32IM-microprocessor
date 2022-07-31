// file: Nbit_reg.v

`timescale 1ns/1ns

module Nbit_reg  #(parameter N =32)(D, clk, rst, load, Q);
  input [N-1:0] D;
  input clk, rst, load;
  output  [N-1:0] Q;
  wire [N-1:0] temp;
  
  genvar i;
  generate
    for (i=0; i<N; i=i+1)
      begin : register
        mux2x1 mux(Q[i], D[i], load, temp[i]);
        DFlipFlop dFF(clk, rst, temp[i], Q[i]);
      end
  endgenerate


endmodule