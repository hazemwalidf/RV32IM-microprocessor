// file: mux2x1.v

`timescale 1ns/1ns

module mux2x1 (input A, B, S, output C);

  assign C=S? B: A;

endmodule