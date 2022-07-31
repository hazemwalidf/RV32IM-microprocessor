`include "defines.v"

module ALU_control(
    input [2:0] ALUop,
    input [2:0] func3,
    input inst30, inst25,
    output reg [4:0] ALUsel
    );
    
    always  @(*) begin 
        casex ({ALUop, func3 ,inst30, inst25})
            8'b000_xxx_x_x: ALUsel = `ALU_ADD; //ADD
            8'b001_xxx_x_x: ALUsel = `ALU_SUB; //SUB
        
            8'b010_000_0_0: ALUsel = `ALU_ADD; //ADD
            8'b010_000_1_0: ALUsel = `ALU_SUB; //SUB
            8'b010_110_0_0: ALUsel = `ALU_OR; //OR
            8'b010_111_0_0: ALUsel = `ALU_AND; //AND
            8'b010_100_x_0: ALUsel = `ALU_XOR; //XOR
            8'b010_101_0_0: ALUsel = `ALU_SRL; //SRL
            8'b010_101_1_0: ALUsel = `ALU_SRA; //SRA
            8'b010_001_x_0: ALUsel = `ALU_SLL; //SLL
            8'b010_010_x_0: ALUsel = `ALU_SLT; //SLT
            8'b010_011_x_0: ALUsel = `ALU_SLTU; //SLTU
            
            8'b011_000_x_x: ALUsel = `ALU_ADD; //ADDI
            8'b011_110_x_x: ALUsel = `ALU_OR; //ORI
            8'b011_111_x_x: ALUsel = `ALU_AND; //ANDI
            8'b011_100_x_x: ALUsel = `ALU_XOR; //XORI
            8'b011_101_0_x: ALUsel = `ALU_SRLI; //SRLI
            8'b011_001_x_x: ALUsel = `ALU_SLLI; //SLLI
            8'b011_101_1_x: ALUsel = `ALU_SRAI; //SRAI
            8'b011_010_x_x: ALUsel = `ALU_SLT; //SLTI
            8'b011_011_x_x: ALUsel = `ALU_SLTU; //SLTIU
            
            8'b100_xxx_x_x: ALUsel = `ALU_PASS; //LUI
            8'b101_xxx_x_x: ALUsel = `ALU_ADD; //AUIPC
            8'b110_xxx_x_x: ALUsel = `ALU_ADD; //JAL
            8'b111_xxx_x_x: ALUsel = `ALU_ADD; //JALR
            
            8'b010_000_0_1: ALUsel = `ALU_MUL; //MUL
            8'b010_001_0_1: ALUsel = `ALU_MULH; //MULH
            8'b010_011_0_1: ALUsel = `ALU_MULHU; //MULHU
            8'b010_010_0_1: ALUsel = `ALU_MULHSU; //MULHSU
            8'b010_100_0_1: ALUsel = `ALU_DIV; //DIV
            8'b010_101_0_1: ALUsel = `ALU_DIVH; //DIVH
            8'b010_110_0_1: ALUsel = `ALU_REM; //REM
            8'b010_111_0_1: ALUsel = `ALU_REMU; //REMU
            
            
            default: ALUsel = 5'b11111;
    
        endcase 
    end
    
endmodule
