#Table B
#Jumps J, JR, JAL
#Branches BEQ, BNE
#Memory Load/Store LW, SW

addiu $1, $0, 0x1         # $1 = 1
addiu $3, $0, 0xa         # $3 = 10
nop
nop
sw $1, 4($0)
nop
nop
nop
loop:
    slti $2, $1, 10      
    nop
    nop
    nop 
    beq $2, $0, exit_loop
    nop
    nop
    addiu $3, $3, -1
    addiu $1, $1, 1
    j loop
    nop
    nop
    
    nop
exit_loop:

lw $1, 4($0)
