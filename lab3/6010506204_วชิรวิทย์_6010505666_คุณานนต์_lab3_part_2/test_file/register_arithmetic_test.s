#Table A

#Immediate arithmetic ADDIU, ANDI, ORI, XORI, SLTI, SLTIU
#Register arithmetic ADDU, SUBU, AND, OR, XOR, NOR, SLT, SLTU
#Shifts (constant) SLL, SRL, SRA

ADDIU $1, $0, 0x5       # $1 = 5
SLTI $5, $1, 0x7        # $5 = 1
SLTIU $6, $1, 0x4       # $6 = 0

ADDU $7, $5, $1         # $7 = 6
subu $8, $5, $1         # $8 = -4
and $9, $7, $5          # $9 = 0
or $10, $7, $6          # $10 = 6
xor $11, $10, $6        # $11 = 6
nor $12, $10, $6        # $12 = -7
slt $13, $11, $7        # $13 = 0
sltu $14, $7, $11       # $14 = 0
