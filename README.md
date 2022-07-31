# RV32IM-microprocessor

Tested Instructions:
1- LW
2- SW
3- ADD
4- SUB
5- OR
6- AND
7- LB
8- SB
9- SLL
10- SLT
11- SLTU
12- XOR
13- SRL
14- SRA
15- BEQ
16- BNE
17- BGE
18- BGEU
19- BLTU
20- LBU
21- ADDI
22- SLTI
23- SLTIU
24- XORI
25- ORI
26- ANDI
27- SLLI
28- SRLI
29- SRAI
30- MUL
31- MULH
32- DIV
33- REM
34- JAL

Untested/Not Working Instructions
1- AUIPC
2- LUI
3- JALR
4- MULHSU
5- MULHU
6- DIVU
7- REMU
8- LH
9- SH
10- FENCE
11- ECALL
12- EBREAK

While it was attempted to work with the unsigned multiplication and division instructions using the $signed() and &unsigned() operators, the result still came out signed. 

Multiple functioning ideas for the halt in the FENCE, ECALL, and EBREAK instructions were present; however, we were not able to implement them before the deadline. 
The first implementation was using the load input of the PC register, setting it to zero if a halt control instruction is = 1, which would be output by the control unit at their given opcodes. This would prevent the PC from incrementing to future instructions.
The second implementation would be to pass the current PC value to the PC MUX, and the selection line would choose the current PC value as the PC in; thus the PC would get stuck at the same instruction.
The third, more complex implementation would be to set the branch control signals to 1, indicating that it will branch; thus taking the PC + immediate value as a PC input. Then, the imm would be set to 0; therefore, PC + imm would be = to the current PC value and the PC would get stuck at the same value.


Implemented Bonuses:

1- Implemented a single memory using another method than the suggested 2-cycle method. It was done using the negative and positive edge of the clock.

2- Added support for the RV32IM instruction set.
