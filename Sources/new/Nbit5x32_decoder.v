// file: Nbit5x32_decoder.v

`timescale 1ns/1ns

module Nbit5x32_decoder
( 
  input [4:0] write_register,
  input regWrite,
  output reg [31:0] load
);
  always @(*) 
  begin
    if (regWrite) begin
       load = 32'd0;
      load[write_register] = 1'b1;
   end  else
      load = 32'd0;
  end
  
endmodule