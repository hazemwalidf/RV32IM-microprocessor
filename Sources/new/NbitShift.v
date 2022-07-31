// file: nbitshift.v
// author: @hazemwalidf

`timescale 1ns/1ns

module nbitshift #(parameter N = 32)(input [N-1:0] num, output [N-1:0] out);
  
  assign out = {num[N-2:0], 1'b0};

endmodule