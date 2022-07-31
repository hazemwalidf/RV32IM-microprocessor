`include "defines.v"

module controlunit(
input [6:2] Inst,
output reg [2:0] ALUop,
output reg [1:0] Branch, MemtoReg,
output reg MemRead, MemWrite, ALUSrc,  RegWrite
    );
    
    always @(*) begin
        case (Inst)
            `OPCODE_Arith_R:
            begin
                Branch = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 2'b0;
                ALUop = 3'b010;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b1;
            end
            
            `OPCODE_Load:
            begin
               Branch = 2'b00;
               MemRead = 1'b1;
               MemtoReg = 2'b01;
               ALUop = 3'b000;
               MemWrite = 1'b0;
               ALUSrc = 1'b1;
               RegWrite = 1'b1; 
            end
            
            `OPCODE_Store:
            begin
                Branch = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 2'b00;
                ALUop = 3'b000;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b0;
            end
            
            `OPCODE_Branch:
            begin
                Branch = 2'b01;
                MemRead = 1'b0;
                MemtoReg = 2'b00;
                ALUop = 3'b001;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
            
            `OPCODE_JALR:
            begin
                Branch = 2'b10;
                MemRead = 1'b1;
                MemtoReg = 2'b10;
                ALUop = 3'b111;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;                
            end
            
            `OPCODE_JAL:
            begin
                Branch = 2'b10;
                MemRead = 1'b1;
                MemtoReg = 2'b10;
                ALUop = 3'b110;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            
            `OPCODE_Arith_I:
            begin
                Branch = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 2'b0;
                ALUop = 3'b011;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            
            `OPCODE_AUIPC:
            begin
                Branch = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 2'b11;
                ALUop = 3'b101;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            
            `OPCODE_LUI:
            begin
                Branch = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 2'b00;
                ALUop = 3'b100;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            
            
             default:
             begin
                 Branch = 2'b00;
                 MemRead = 1'b0;
                 MemtoReg = 2'b00;
                 ALUop = 3'b000;
                 MemWrite = 1'b0;
                 ALUSrc = 1'b0;
                 RegWrite = 1'b0;
             end
             
        endcase 
    end


endmodule