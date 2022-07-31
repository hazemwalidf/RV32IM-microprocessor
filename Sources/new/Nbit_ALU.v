`include "defines.v"

module ALU(
	input   wire [31:0] a, b,      // inputs
	input   wire [4:0]  shamt,     // shift amount
	output  reg  [31:0] r,         //
	output  wire cf, zf, vf, sf,                       // cf = Carry       zf = zeroFlag       vf = Overflow flag      sf = Negative flag
	input   wire [4:0]  alufn      // ALU Select
);

    wire [31:0] add, op_b;
    wire [63:0] int_mul; //intermediate wire
    wire [63:0] int_div; //intermediate wire
//    wire cfa, cfs;
    
    assign op_b = (~b);
    
    wire [31:0] unsigned_a, unsigned_b;
    assign unsigned_a = {1'b0, a[30:0]};
    assign unsigned_b = {1'b0, b[30:0]};
    
    assign {cf, add} = alufn[1] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    reg [4:0] amount;
    
    always @(*) begin
        if ( (alufn == `ALU_SRL) || (alufn == `ALU_SLL) || (alufn == `ALU_SRA)  )
            amount = b;
        else amount = shamt;
    end
    
    shifter shifter0(.a(a), .shamt(amount), .type(alufn),  .r(sh));
    
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            `ALU_ADD: r = add;
            `ALU_SUB: r = add;
            `ALU_PASS: r = b;
            // logic
            `ALU_OR:  r = a | b;
            `ALU_AND:  r = a & b;
            `ALU_XOR:  r = a ^ b;
            // shift
            `ALU_SRL:  r=sh;
            `ALU_SLL:  r=sh;
            `ALU_SRA:  r=sh;
            `ALU_SRLI:  r=sh;
            `ALU_SLLI:  r=sh;
            `ALU_SRAI:  r=sh;
            // slt & sltu
            `ALU_SLT:  r = {31'b0,(sf != vf)};
            `ALU_SLTU:  r = {31'b0,(~cf)};
            // multiplication
            `ALU_MUL:   r = a*b;
            `ALU_MULH:  r = $signed(a) * $signed(b);
            `ALU_MULHU: r = $unsigned(a) * $unsigned(b);
            `ALU_MULHSU: r = $signed(a) * $unsigned(b);
            `ALU_DIV: r = a/b;
            `ALU_DIVH: r = $unsigned(a) / $unsigned(b);
            `ALU_REM: r = a%b;
            `ALU_REMU: r = $unsigned(a) % $unsigned(b);
            
        endcase
    end
endmodule