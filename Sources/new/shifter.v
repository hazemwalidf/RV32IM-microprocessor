`include "defines.v"

module shifter(
input [31:0] a,
input [4:0] shamt,
input [4:0] type,
output reg [31:0] r
    );
    
    always @(*) begin
        case(type)
            `ALU_SRL: r = a >> shamt;
            `ALU_SRA: r = a >>> shamt;
            `ALU_SLL: r = a << shamt;
            `ALU_SRLI: r = a >> shamt;
            `ALU_SRAI: r = a >>> shamt;
            `ALU_SLLI: r = a << shamt;
            default : r = 0;
        endcase
    end

endmodule
