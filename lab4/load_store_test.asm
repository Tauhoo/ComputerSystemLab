addiu $1, $1, 0x5
addiu $2, $2, 0x2
nop
nop
nop
sw $1, 0($2)
lw $2, 0($2)