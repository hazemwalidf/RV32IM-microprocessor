`include "defines.v"

module RISCV_pipelined(
input [1:0] LEDSel,
input [3:0] SSDSel,
input rst,
input clk,
input SSD_clk,
output reg [15:0] LED_out,
output reg [12:0] SSD_out       // delay = 0.01 ns
    );
    
    wire [31:0] PC_in, PC_out;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2;
    //wire [2:0] ALUop;
    //wire [1:0] Branch, MemtoReg;
    //wire MemRead, MemWrite, ALUSrc,  RegWrite;
    wire [31:0] generator_out;
    wire [31:0] ALU_input, ALU_out;
    wire [4:0] ALUSel;
    wire zeroFlag, Cout1, Cout2, Cout3;
    wire [31:0] memory_out, shift_out, adder1_out, adder2_out, write_data;
    wire adder_sel;
    wire stall;
    wire not_stall;
    assign not_stall = ~stall;
    wire [7:0] addr;
    
  
    // ID/EX WIRES
    wire [31:0] IF_ID_PC, IF_ID_Inst;
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire [10:0] ID_EX_Ctrl;
    wire [3:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
    wire [10:0] control_out ;
//    = {Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite};
    
    
    // EX/MEM WIRES
    // Rs1 and Rs2 are needed later for the forwarding unit
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
    wire [10:0] EX_MEM_Ctrl;
    wire [4:0] EX_MEM_Rd;
    wire EX_MEM_Zero;
    
     
    //MEM/WB WIRES
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire [10:0] MEM_WB_Ctrl;
    wire [10:0] hazard_mux_out;
    
    wire [4:0] MEM_WB_Rd;
    
    wire [31:0] NO_OP = 32'b0000000_00000_00000_000_00000_0110011;
    wire [31:0] flush_inst ;
    
    
    
    
    
    // DECODING PHASE
    Nbit_reg #(32) PC(.D(PC_in), .clk(clk), .rst(rst), .load(1'b1), .Q(PC_out));
    Nbit2x1_MUX #(8) Mem_MUX( .A(EX_MEM_ALU_out[7:0]), .B(PC_out[7:0]), .S(clk), .C(addr) );
    
    /*
    module single_mem(
    input clk, rst,
    input MemRead, MemWrite,
    input [7:0] addr,
    input [31:0] data_in,
    input [2:0] func3,
    output reg [31:0] data_out
        );
    */
    single_mem memory( .clk(clk), .rst(rst), .MemRead(EX_MEM_Ctrl[`CTRL_MemRead]), .MemWrite(EX_MEM_Ctrl[`CTRL_MemWrite]), 
                        .addr(addr), .data_in(EX_MEM_RegR2), .func3(EX_MEM_Func[2:0]), .data_out(memory_out) );
    // InstMem instruction_memory(.addr(PC_out[7:2]), .data_out(instruction));
    // DataMem data_memory(.clk(clk), .MemRead(EX_MEM_Ctrl[`CTRL_MemRead]), .MemWrite(EX_MEM_Ctrl[`CTRL_MemWrite]), 
                        // .addr(EX_MEM_ALU_out[7:0]), .data_in(EX_MEM_RegR2), .func3(EX_MEM_Func[2:0]), .data_out(memory_out) );
    Nbit_RCA #(32) adder_4(.A(PC_out), .B(32'd4), .Cin(1'b0), .Sum(adder1_out), .Cout(Cout2));
    
    
    
    //Nbit2x1_MUX #(32) IF_ID_MUX(.A(memory_out), .B(NO_OP), .S(adder_sel), .C(flush_inst));
    assign flush_inst = memory_out;

    wire [31:0] IF_ID_adder1;
    // IF/ID REGISTER
    Nbit_reg #(200) IF_ID ( .D({PC_out, flush_inst, adder1_out}), .clk(~clk), .rst(rst), .load(1'b1), .Q({IF_ID_PC, IF_ID_Inst, IF_ID_adder1}) );
    
    
    
    // DECODING PHASE
    register_file #(32) RF( .read_register1(IF_ID_Inst[`IR_rs1]), .read_register2(IF_ID_Inst[`IR_rs2]), .write_register(MEM_WB_Rd),
                             .write_data(write_data), .regWrite(MEM_WB_Ctrl[0]), .clk(~clk), .rst(rst), .read_data1(read_data1), .read_data2(read_data2) );
    
    ImmGen immediate_generator( .IR(IF_ID_Inst), .Imm(generator_out) );
    
    controlunit control_unit( .Inst(IF_ID_Inst[`IR_opcode]), .ALUop(control_out[`CTRL_ALUOp]), .Branch(control_out[`CTRL_Branch]), .MemtoReg(control_out[`CTRL_MemtoReg]),
                        .MemRead(control_out[`CTRL_MemRead]), .MemWrite(control_out[`CTRL_MemWrite]), .ALUSrc(control_out[`CTRL_ALUSrc]), .RegWrite(control_out[`CTRL_RegWrite]) ); 
                       
    // hazard_detection hazard( .IF_ID_RegisterRs1(IF_ID_Inst[`IR_rs1]), .IF_ID_RegisterRs2(IF_ID_Inst[`IR_rs2]), 
    //                       .ID_EX_RegisterRd(ID_EX_Rd), .ID_EX_MemRead(ID_EX_Ctrl[`CTRL_MemRead]), .stall(stall) );
    
    Nbit2x1_MUX #(11) control_MUX( .A(control_out), .B(11'b0), .S((adder_sel)), .C(hazard_mux_out) );  
                   
    wire ID_EX_inst25;                        
                            
    // ID/EX REGISTER
    wire [31:0] ID_EX_adder1;    
    Nbit_reg #(230) ID_EX ( .D({IF_ID_adder1, hazard_mux_out, IF_ID_PC, read_data1, read_data2, generator_out, 
                           {IF_ID_Inst[30], IF_ID_Inst[`IR_funct3]}, IF_ID_Inst[`IR_rs1], IF_ID_Inst[`IR_rs2],IF_ID_Inst[`IR_rd], IF_ID_Inst[25]}),
                           .clk(clk), .rst(rst), .load(1'b1), 
                           .Q({ID_EX_adder1, ID_EX_Ctrl, ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, ID_EX_Func, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, ID_EX_inst25} ) );        
                             
                             
                             
    // EXECUTION PHASE
    wire forwardA, forwardB;
//    nbitshift #(32) shifter( .num(ID_EX_Imm), .out(shift_out) );
    assign  shift_out = ID_EX_Imm;
    Nbit_RCA #(32) branch_adder( .A(ID_EX_PC), .B(shift_out), .Cin(1'b0), .Sum(adder2_out), .Cout(Cout3) );
    
    wire [31:0] MUX_forward;
    wire [31:0] ALU_in1;
    wire [10:0] flush_control;
    wire vf, sf;
    
    assign ALU_in1 = (forwardA) ? write_data : ID_EX_RegR1;
    assign MUX_forward = (forwardB) ? write_data : ID_EX_RegR2;
    // assign MUX_forward = (forwardB) ? ID_EX_RegR2 :  write_data;
    assign ALU_input = (ID_EX_Ctrl[`CTRL_ALUSrc]) ? ID_EX_Imm : MUX_forward;
    
    /*
    MUX_4x2 ALUMUX2( .A(ID_EX_RegR2), .B(write_data),  .C(EX_MEM_ALU_out), .D(32'b0), .Sel(forwardB), .Out(MUX_forward) );
    Nbit2x1_MUX #(32) MUX_ALUin2( .A(MUX_forward), .B(ID_EX_Imm), .S(ID_EX_Ctrl[`CTRL_ALUSrc]), .C(ALU_input) );
    
    MUX_4x2 MUX_ALUin1( .A(ID_EX_RegR1), .B(write_data), .C(EX_MEM_ALU_out), .D(32'b0), .Sel(forwardA), .Out(ALU_in1) );
    */
        
    ALU_control ALUControl( .ALUop(ID_EX_Ctrl[`CTRL_ALUOp]), .func3(ID_EX_Func[2:0]), .inst30(ID_EX_Func[3]), .inst25(ID_EX_inst25), .ALUsel(ALUSel) );
    
    ALU myALU( .a(ALU_in1), .b(ALU_input), .shamt(ID_EX_Rs2), .r(ALU_out), .cf(Cout1), .zf(zeroFlag), .vf(vf), .sf(sf), .alufn(ALUSel));
    
    forwarding_unit forward(.ID_EX_RegisterRs1(ID_EX_Rs1), .ID_EX_RegisterRs2(ID_EX_Rs2), .EX_MEM_RegWrite(EX_MEM_Ctrl[`CTRL_RegWrite]), 
                            .EX_MEM_RegisterRd(EX_MEM_Rd), .MEM_WB_RegWrite(MEM_WB_Ctrl[`CTRL_RegWrite]), .MEM_WB_RegisterRd(MEM_WB_Rd), .forwardA(forwardA), .forwardB(forwardB) );
    
    Nbit2x1_MUX #(11) flush_EX_MUX( .A(ID_EX_Ctrl), .B(11'b0), .S(adder_sel), .C(flush_control) );
   
   
   
   
    // EX/MEM REGISTER
    wire [31:0] EX_MEM_adder1;
    wire [3:0] EX_MEM_Func;
    wire EX_MEM_cf, EX_MEM_vf, EX_MEM_sf;
    Nbit_reg #(250) EX_MEM ( .D( {ID_EX_adder1, flush_control, adder2_out, zeroFlag, ALU_out, MUX_forward, ID_EX_Rd, ID_EX_Func[2:0], Cout1, vf, sf} ), .clk(~clk), .rst(rst), .load(1'b1),
                             .Q( {EX_MEM_adder1, EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Zero, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd, EX_MEM_Func[2:0], EX_MEM_cf, EX_MEM_vf, EX_MEM_sf})  );
    
    
    
    
    // MEMORY PHASE
    Branch_CTRLU branch_control( .func3(EX_MEM_Func[2:0]), .branch(EX_MEM_Ctrl[`CTRL_Branch]), .cf(EX_MEM_cf), .zf(EX_MEM_Zero), .vf(EX_MEM_vf), .sf(EX_MEM_sf), .o(adder_sel));
    
    // DataMem data_memory(.clk(clk), .MemRead(EX_MEM_Ctrl[`CTRL_MemRead]), .MemWrite(EX_MEM_Ctrl[`CTRL_MemWrite]), .addr(EX_MEM_ALU_out[7:0]), .data_in(EX_MEM_RegR2), .func3(EX_MEM_Func[2:0]), .data_out(memory_out) );
    
    MUX_4x2 PC_MUX( .A(adder1_out), .B(EX_MEM_BranchAddOut), .C(0), .D(EX_MEM_ALU_out), .Sel({EX_MEM_Ctrl[10], adder_sel}), .Out(PC_in) );
    
    
    
    
    // MEM/WB REGISTER
    wire [31:0] MEM_WB_adder1;
    Nbit_reg #(120) MEM_WB ( .D( {EX_MEM_adder1, EX_MEM_Ctrl, memory_out, EX_MEM_ALU_out, EX_MEM_Rd} ), .clk(clk), .rst(rst), .load(1'b1),
                            .Q( {MEM_WB_adder1, MEM_WB_Ctrl, MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd} ) );
    
    
    

    // WRITEBACK PHASE
    MUX_4x2 WB_MUX(  .A(MEM_WB_ALU_out), .B(MEM_WB_Mem_out), .C(MEM_WB_adder1), .D(adder2_out), .Sel(MEM_WB_Ctrl[`CTRL_MemtoReg]), .Out(write_data) );
    
    
    
    always @(*) begin
        case(SSDSel) 
            4'b0000: SSD_out = PC_out[12:0];
            4'b0001: SSD_out = adder1_out[12:0];
            4'b0010: SSD_out = adder2_out[12:0];
            4'b0011: SSD_out = PC_in[12:0];
            4'b0100: SSD_out = read_data1[12:0];
            4'b0101: SSD_out = read_data2[12:0];
            4'b0110: SSD_out = write_data[12:0];
            4'b0111: SSD_out = generator_out[12:0];
            4'b1000: SSD_out = shift_out[12:0];
            4'b1001: SSD_out = ALU_input[12:0];
            4'b1010: SSD_out = ALU_out[12:0];
            4'b1011: SSD_out = memory_out[12:0];
            default :SSD_out=0;
        endcase
        
        case(LEDSel)
            2'b00: LED_out = instruction[15:0];
            2'b01: LED_out = instruction[31:16];
            2'b10: LED_out = {2'b0,  ALUSel, zeroFlag, adder_sel};
            default: LED_out=0;
        endcase
    end
    
    
endmodule
