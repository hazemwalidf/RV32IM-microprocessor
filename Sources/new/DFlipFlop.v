// file: DFlipFlop.v

`timescale 1ns/1ns

module DFlipFlop  (input clk, rst, D, output reg Q);

  always @ (posedge clk or posedge rst)
    if (rst) begin
      Q <= 1'b0;
    end 
    else begin
      Q <= D;
    end 

endmodule