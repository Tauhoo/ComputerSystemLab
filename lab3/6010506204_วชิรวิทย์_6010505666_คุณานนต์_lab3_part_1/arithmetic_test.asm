#Table A

#Immediate arithmetic ADDIU, ANDI, ORI, XORI, SLTI, SLTIU
#Register arithmetic ADDU, SUBU, AND, OR, XOR, NOR, SLT, SLTU
#Shifts (constant) SLL, SRL, SRA

addiu $1, $0, 0x5       # $1 = 5
andi $2, $1, 1          # $2 = 1
ori $3, $2, 0x0         # $3 = 1
xori $4, $2, 0x1        # $4 = 0
slti $5, $1, 0x7        # $5 = 1
sltiu $6, $1, 0x4       # $6 = 0
