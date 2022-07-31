`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:26:43 AM
// Design Name: 
// Module Name: single_mem
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


module single_mem(
input clk, rst,
input MemRead, MemWrite,
input [7:0] addr,
input [31:0] data_in,
input [2:0] func3,
output [31:0] data_out
    );
    wire [7:0] offset = addr + 8'd128;
    reg [31:0] mem [0:255];
    reg [31:0] inst_out;
    reg [31:0] data_mem_out;
    
    assign data_out = (clk)? inst_out : data_mem_out;
    
    
    always @(*) begin
        inst_out = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
    end
        
    always @(*) begin    
        if (MemRead)
        case(func3)
        3'b000: data_mem_out = {{24{mem[offset][7]}}, mem[offset]};                      //LB
        3'b001: data_mem_out = {{16{mem[offset + 1][7]}}, mem[offset + 1], mem[offset]};       //LH
        3'b010: data_mem_out = {mem[offset + 3], mem[offset + 2], mem[offset + 1], mem[offset]};   //LW
        3'b100: data_mem_out = {{24{1'b0}}, mem[offset]};                              //LBU
        3'b101: data_mem_out = {{16{1'b0}}, mem[offset + 1], mem[offset]};                 //LHU
        default: data_mem_out = 0;
        endcase
        else data_mem_out = 0;
    end

      
      // writing
      always @(posedge clk) begin
        if (MemWrite)
        case(func3)
        3'b000: mem[offset] = data_in[7:0];   //SB
        3'b001: {mem[offset + 1], mem[offset]} = data_in[15:0];    //SH
        3'b010: {mem[offset + 3], mem[offset + 2], mem[offset + 1], mem[offset]} = data_in;   //SW
        endcase
      end
      
      initial begin
       {mem[3 + 128], mem[2 + 128], mem[1 + 128], mem[0 + 128]}=32'd17;
       {mem[7 + 128], mem[6 + 128], mem[5 + 128], mem[4 + 128]}=32'd9; 
       {mem[11 + 128], mem[10 + 128], mem[9 + 128], mem[8 + 128]}=32'd25;
      end 
      
      
      
      // INSTRUCTIONS
      initial begin
           {mem[3], mem[2], mem[1], mem[0]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
           //added to be skipped since PC starts with 4 after reset
           {mem[7], mem[6], mem[5], mem[4]}=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
           {mem[11], mem[10], mem[9], mem[8]}=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
           {mem[15], mem[14], mem[13], mem[12]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
           // {mem[19], mem[18], mem[17], mem[16]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
           {mem[19], mem[18], mem[17], mem[16]}=32'b000000001001_00001_110_00100_0010011 ; //ori x4, x1, 9
           // {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00011_00100_000_00100_0_1100011; //beq x4, x3, 4
           // {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00010_00001_001_0100_0_1100011; //bne x1, x2, 4
           // {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00001_00010_100_0100_0_1100011; //blt x2, x1, 4
           // {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00010_00001_101_0100_0_1100011; //bge x1, x2, 4
           // {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00001_00010_110_0100_0_1100011; //bltu x2, x1, 4
           {mem[23], mem[22], mem[21], mem[20]}=32'b0_000000_00010_00001_111_0100_0_1100011; //bgeu x1, x2, 4
           {mem[27], mem[26], mem[25], mem[24]}=32'b0000000_00010_00001_100_00011_0110011 ; //add x3, x1, x2     
           // {mem[31], mem[30], mem[29], mem[28]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2
           {mem[31], mem[30], mem[29], mem[28]}=32'b000000001001_00011_000_00101_0010011 ; //addi x5, x3, 9
           {mem[35], mem[34], mem[33], mem[32]}=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
           {mem[39], mem[38], mem[37], mem[36]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)
           // {mem[43], mem[42], mem[41], mem[40]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
           {mem[43], mem[42], mem[41], mem[40]}=32'b000000111111_00110_111_00111_0010011 ; //andi x7, x6, 63
           {mem[47], mem[46], mem[45], mem[44]}=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
           {mem[51], mem[50], mem[49], mem[48]}=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
           {mem[55], mem[54], mem[53], mem[52]}=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
           {mem[59], mem[58], mem[57], mem[56]}=32'b000000000101_00010_100_01010_0010011 ; //xori x10, x2, 5
           {mem[63], mem[62], mem[61], mem[60]}=32'b0000000_00001_00010_001_01011_0010011 ; //slli x11, x2, 1
           {mem[67], mem[66], mem[65], mem[64]}=32'b0000000_00001_01011_101_01100_0010011 ; //srli x12, x11, 1
           {mem[71], mem[70], mem[69], mem[68]}=32'b0100000_00001_01011_101_01101_0010011 ; //srai x13, x11, 1
           {mem[75], mem[74], mem[73], mem[72]}=32'b000000000010_00000_000_01110_0010011 ; //addi x14, x0, 2
           {mem[79], mem[78], mem[77], mem[76]}=32'b0000000_01110_00010_001_01111_0110011 ; //sll x15, x2, x14 
           {mem[83], mem[82], mem[81], mem[80]}=32'b0000000_01110_01111_101_10000_0110011 ;  //srl x16, x15, x14
           {mem[87], mem[86], mem[85], mem[84]}=32'b000000001010_00010_010_10001_0010011 ; //slti x17, x2, 10
           {mem[91], mem[90], mem[89], mem[88]}=32'b0000000_00001_00010_010_10010_0110011 ; //slt x18, x2, x1
           {mem[95], mem[94], mem[93], mem[92]}=32'b0_0000001010_0_00000000_10011_1101111 ; //jal x19, 20
           {mem[99], mem[98], mem[97], mem[96]}=32'b0000001_01001_01001_000_10100_0110011 ; //mul x19, x9, x9 
           {mem[103], mem[102], mem[101], mem[100]}=32'b0000001_01110_01001_110_10101_0110011 ; /rem x21, x9, x14


           // {mem[99], mem[98], mem[97], mem[96]}=32'b000000001000_00010_000_10100_1100111 ;
           
           
           /*
           mem[0]=32'h00400093;      //addi x1,x0,4 #x1=4                        
           mem[1]=32'h00800113  ;    //addi x2,x0,8 #x2=8                        
           mem[2]=32'h00300193  ;    //addi x3,x0,3 #x2=3                        
           mem[3]=32'h21100213  ;    //addi x4,x0,529 #x4=529                     
           mem[4]=32'h0010a023  ;    //sw x1,0(x1) # mem(4)=4                    
           mem[5]=32'h00412023  ;    //sw x4,0(x2) # mem(8)=528                  
           mem[6]=32'h00410223  ;    //sb x4,4(x2) # mem(12)=528                  
           mem[7]=32'h001102a3  ;    //sb x1,5(x2) # mem(13)=4                    
           mem[8]=32'h00411423  ;    //sh x4,8(x2) # mem(13)=528                  
           mem[9]=32'h00111523  ;    //sh x1,10(x2) # mem(13)=100                 
           mem[10]=32'h00012503 ;    //lw x10,0(x2) # x10= 528                   
           mem[11]=32'h00510583 ;    //lb x11,5(x2) # x11= 4 
           mem[12]=32'b0000000_00010_01100_001_01010_0100011 ; // lh x12, 10(x2)
           */
      end
    
    
    
endmodule
