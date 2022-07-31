// file: register.v

`timescale 1ns/1ns

module register_file #(parameter N=32)(
  input [4:0] read_register1, read_register2, write_register,
  input [N-1:0] write_data,
  input regWrite,
  input clk, rst,
  output  [N-1:0] read_data1, read_data2
);
  wire [N-1:0]Q[31:0];
  wire [31:0] load;
  Nbit5x32_decoder decode(write_register, regWrite, load);
  
  genvar i;
  generate
  for (i=1; i<N; i=i+1)
  begin
    Nbit_reg onereg(write_data, clk, rst, load[i], Q[i]);
  end
  endgenerate
  
  Nbit_reg onereg(1'b0, clk, rst, 1'b0, Q[0]);
  
  assign read_data1 = Q[read_register1];
  assign read_data2 = Q[read_register2];
  

endmodule