.data

space: .asciiz " "
new_line: .asciiz "\n"

.text

.globl main

printArray:
    
    # save return address and frame point
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    move $fp, $sp # update frame point

    li $t0, 0 # i = 0
    lw $t1, 8($fp) # base address of arr[]
    lw $t3, 12($fp) # load n

    loop: 
        slt $t2, $t0, $t3 # check if i < 0
        beq $t2, $0, exit_loop 

        # calculate address 
        sll $t2, $t0, 2 
        add $t2, $t1, $t2 

        # print value
        li $v0, 1
        lw $a0, 0($t2)
        syscall

        # print " "
        li $v0, 4
        la $a0, space
        syscall

        addi $t0, $t0, 1 # i++
        j loop
    exit_loop:

    # printf("\n");
    li $v0, 4
    la $a0, new_line
    syscall

    # restore return address and frame point
    lw $ra, 4($fp)
    sw $fp, 0($fp)
    addi $sp, $sp, 8

    jr $ra

insertionSortRecursive:
    # save return address and frame point
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    move $fp, $sp # update frame point

    # declare parameter
    lw $t0, 8($sp) # declare arr
    lw $t1, 12($sp) # declare n

    li $t2, 1
    slt $t2, $t2, $t1 # check if n > 1
    beq $t2, $0, exit_func # return function

    addi $t2, $t1, -1 # declare n - 1

    #### call insertionSortRecursive ####

    # caller save register
    addi $sp, $sp, -8
    sw $t0, 0($sp) 
    sw $t1, 4($sp)

    addi $sp, $sp, -8
    sw $t0, 0($sp)
    sw $t2, 4($sp)
        
    jal insertionSortRecursive

    addi $sp, $sp, 8

    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8

    #### 

    addi $t2, $t1, -1 # find n - 1
    sll $t2, $t2, 2 # shift n - 1
    add $t2 ,$t0, $t2 # calculate address

    lw $t3, 0($t2) # declare last = arr[n - 1]
    addi $t4, $t1, -2 # declare j = n - 2

    #### while loop ####
    loop_while:
        slt $t2, $t4, $0 # check if j < 0
        not $t2, $t2 # get j >= 0

        sll $t5, $t4, 2 # shift j
        add $t5, $t5, $t0 # calculate address arr[j]
        lw $t5, 0($t5) # load arr[j] 
        slt $t5, $t3, $t5 # check if last < arr[j] 

        and $t2, $t5, $t2 # j >= 0 && last < arr[j] 
        beq $t2, $0, exit_loop_while # exit loop

        sll $t2, $t4, 2 # shift j
        add $t2, $t0, $t2 # calculate address arr[j]
        lw $t2, 0($t2) # load arr[j]

        addi $t5, $t4, 1 # find j + 1
        sll $t5, $t5, 2 # shift j + 1
        add $t5, $t0, $t5 # calculate arr[j+1] address

        sw $t2, 0($t5) # arr[j+1] = arr[j]; 

        addi $t4, $t4, -1 # j--;
        j loop_while
    exit_loop_while:
    ####

    addi $t5, $t4, 1 # find j + 1
    sll $t5, $t5, 2 # shift j + 1
    add $t5, $t0, $t5 # calculate arr[j+1] address

    sw $t3, 0($t5) # arr[j+1] = last;

    exit_func:

    # restore register
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8

    jr $ra

main:
    ##### declare array #####
    addi $sp, $sp, -48
    move $s0, $sp # store array pointer (data[])

    li $s1, 132470
    sw $s1, 0($s0) # data[0] = 132470

    li $s1, 324545
    sw $s1, 4($s0) # data[1] = 324545

    li $s1, 73245
    sw $s1, 8($s0) # data[2] = 73245

    li $s1, 93245
    sw $s1, 12($s0) # data[3] = 93245

    li $s1, 80324542
    sw $s1, 16($s0) # data[4] = 80324542

    li $s1, 244
    sw $s1, 20($s0) # data[5] = 244

    li $s1, 2
    sw $s1, 24($s0) # data[6] = 2

    li $s1, 66
    sw $s1, 28($s0) # data[7] = 66

    li $s1, 236
    sw $s1, 32($s0) # data[8] = 236

    li $s1, 327
    sw $s1, 36($s0) # data[9] = 327

    li $s1, 236
    sw $s1, 40($s0) # data[10] = 236

    li $s1, 21544
    sw $s1, 44($s0) # data[11] = 21544

    ####

    li $s1, 12 # store N value

    #### call printArray function ####

    # save argument
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal printArray

    # return memory from argument
    addi $sp, $sp, 8 

    ####

    #### call insertionSortRecursive function ####

    # save argument
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal insertionSortRecursive

    # return memory from argument
    addi $sp, $sp, 8 

    ####

    #### call printArray function ####

    # save argument
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal printArray

    # return memory from argument
    addi $sp, $sp, 8 

    ####

    
    addi $sp, $sp, 48 # free array
    li $v0, 10
    syscall