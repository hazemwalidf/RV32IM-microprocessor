// file: DataMem.v
// author: @hazemwalidf

`timescale 1ns/1ns

module DataMem(
input clk, input MemRead, input MemWrite,
input [7:0] addr, 
input [31:0] data_in, 
input [2:0] func3,  
output reg [31:0] data_out
);
    reg [7:0] mem [0:63];
 
  // reading
  always @(*) begin
    if (MemRead)
     case(func3)
     3'b000: data_out = {{24{mem[addr][7]}}, mem[addr]};                      //LB
     3'b001: data_out = {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]};       //LH
     3'b010: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};   //LW
     3'b100: data_out = {{24{1'b0}}, mem[addr]};                              //LBU
     3'b101: data_out = {{16{1'b0}}, mem[addr+1], mem[addr]};                 //LHU
     default:data_out=0;
     endcase
     else data_out=0;
  end
  
  // writing
  always @(posedge clk) begin
    if (MemWrite)
    case(func3)
    3'b000: mem[addr] = data_in[7:0];   //SB
    3'b001: {mem[addr+1],mem[addr]} = data_in[15:0];    //SH
    3'b010: {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]} = data_in;   //SW
    endcase
  end
  
  initial begin
   {mem[3],mem[2], mem[1],mem[0]}=32'd17;
   {mem[7],mem[6], mem[5],mem[4]}=32'd9; 
   {mem[11],mem[10], mem[9],mem[8]}=32'd25;
    end 


 
endmodule