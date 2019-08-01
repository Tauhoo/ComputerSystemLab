
.data # data section
source: .word 3, 1, 4, 1, 5, 9, 0 
dest: .space 40

.text # text section

.globl main # call main by SPIM

main:

la $10, source #declare source array address 
la $11, dest #declare destination array address 

li $12, 0 #initail for loop index
LOOP:
    add $13, $12, $10 #calculate source array address
    lw $13, 0($13) #load source[k]
    beq $13, $0, ENDLOOP #check if source[k] == 0

    add $14, $12, $11 #calculate destination array address
    sw $13, 0($14) #dest[k] = source[k]
    addi $12, $12, 4 #increase array index
    j LOOP
ENDLOOP:
  
li	$v0, 10
syscall
