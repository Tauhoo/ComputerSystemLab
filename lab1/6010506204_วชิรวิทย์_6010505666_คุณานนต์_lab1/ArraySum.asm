
.data # data section

arrayA: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
arrayB: .word 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9, 0x7ffffff8, 0x7ffffff7, 0x7ffffff6

headA: .asciiz "Sum of a = "
headB: .asciiz "Sum of b = "
tail: .asciiz "\n"


.text # text section

.globl main # call main by SPIM

main:

la $10, arrayA #get arrayA address

li $11, 0 #declare arrayA index
li $12, 20 #declare comparator
li $15, 0 #sum = 0

LOOPA:
    slt $13, $11, $12 #check if index < 20
    beq $13, $0, ENDLOOPA #exit loop if index  >= 2

    sll $14, $11, 2 #shift index 
    add $14, $10, $14 #calculate array address
    lw $14, 0($14) #load arrayA[i]

    addu $15, $14, $15 #sum = sum + arrayA[i]
    addi $11, $11, 1  #increase array index
    j LOOPA  
ENDLOOPA:

li $v0, 4 #print sum value
la $a0, headA
syscall

li $v0, 1 #print sum value
addu $a0, $15, $0
syscall 

li $v0, 4 #print sum value
la $a0, tail
syscall

la $10, arrayB #get arrayB address

li $11, 0 #declare arrayB index
li $12, 10 #declare comparator
li $15, 0 #sum = 0

LOOPB:
    slt $13, $11, $12 #check if index < 20
    beq $13, $0, ENDLOOPB #exit loop if index  >= 2

    sll $14, $11, 2 #shift index 
    add $14, $10, $14 #calculate array address
    lw $14, 0($14) #load arrayA[i]

    addu $15, $14, $15 #sum = sum + arrayA[i]
    addi $11, $11, 1  #increase array index
    j LOOPB
ENDLOOPB:

li $v0, 1 #print sum value

li $v0, 4 #print sum value
la $a0, headA
syscall

li $v0, 1 #print sum value
addu $a0, $15, $0
syscall 

li $v0, 4 #print sum value
la $a0, tail
syscall

li	$v0, 10
syscall
