
.data # data section
A: .word 0, 2, 1, 6, 4, 3, 5, 3
B: .space 32
C: .space 28

headA: .asciiz "A[] = \n"
headB: .asciiz "B[] = \n"

tab: .asciiz " "
nline: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

main:

la $10, A
la $11, B
la $12, C

li $13, 1 # i = 1
li $14, 8 # n = 8
li $15, 7 # k = 7

LOOP1: 
    slt $16, $13, $14 #check if i < n
    beq $16, $0, ENDLOOP1 #exit loop if i >= n

    sll $16, $13, 2 #shift index
    add $16, $16, $10 #calcuate address array A

    lw $16, 0($16) # load A[i]
    sll $16, $16, 2 # shift A[i]
    add $16, $16, $12 # calculat address
    lw $17, 0($16) # load C[A[i]]
    addi $17, $17, 1 # C[A[i]]++
    sw $17, 0($16) # store C[A[i]]

    addi $13, $13, 1 #i++
    j LOOP1
ENDLOOP1:

li $13, 2 # i = 2

LOOP2: 
    slt $16, $13, $15 # check if i < k
    beq $16, $0, ENDLOOP2 # exit loop if i >= k
    
    sll $16, $13, 2 # shift index
    add $16, $16, $12 # calculate address C[i]
    addi $17, $16, -4 # calculate address C[i - 1]

    lw $17, 0($17) #load C[i - 1]
    lw $18, 0($16) #load C[i]

    add $18, $17, $18 # C[i] = C[i] + c[i - 1]
    sw $18, 0($16) # store C[i]
    
    addi $13, $13, 1 #i++
    j LOOP2
ENDLOOP2:

addi $13, $14, -1 # i = n - 1
li $9, 1 #

LOOP3:
    slt $16, $13, $9 # check if i < 1
    beq $16, $9, ENDLOOP3 # exit loop if i < 1

    sll $16, $13, 2 # shift i
    add $16, $16, $10 # calculate address array A
    
    lw $15, 0($16) # load array A[i]
    sll $16, $15, 2 # shift A[i]
    add $18, $16, $12 # calculate C[A[i]] address
    
    lw $17, 0($18) # load C[A[i]]
    sll $16, $17, 2 # shift C[A[i]]
    add $16, $16, $11 # calculate B[C[A[i]]] address

    sw $15, 0($16) # B[C[A[i]]] = A[i]

    addi $17, $17, -1 # C[A[i]] = C[A[i]] -1
    sw $17, 0($18) # store C[A[i]]

    addi $13, $13, -1 # i = i - 1
    j LOOP3
ENDLOOP3:

li $v0, 4
la $a0, headA
syscall

li $13, 1 # i = 1

LOOPA:
    slt $16, $13, $14 # check if i < n
    beq $16, $0, ENDLOOPA # exit loop if i >= n

    sll $16, $13, 2 # shift i
    add $16, $16, $10 # calculate A[i] address

    lw $16, 0($16) # load A[i]

    li $v0, 4
    la $a0, tab # print " "
    syscall

    li $v0, 1
    add $a0, $16, $0 # set B[i] to $a0
    syscall # print A[i]

    addi $13, $13, 1 # i++
    j LOOPA
ENDLOOPA:   

li $v0, 4
la $a0, nline
syscall

la $a0, headB
syscall

li $13, 1 # i = 1

LOOPB:
    slt $16, $13, $14 # check if i < n
    beq $16, $0, ENDLOOPB # exit loop if i >= n

    sll $16, $13, 2 # shift i
    add $16, $16, $11 # calculate B[i] address

    lw $16, 0($16) # load B[i]

    li $v0, 4 
    la $a0, tab 
    syscall # print " "

    li $v0, 1
    add $a0, $16, $0 # set B[i] to $a0
    syscall # print B[i]

    addi $13, $13, 1 # i++
    j LOOPB
ENDLOOPB:   

li $v0, 4
la $a0, nline
syscall

li	$v0, 10
syscall
