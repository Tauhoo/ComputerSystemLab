.data 

new_line: .asciiz "\n"

.text

.globl main

rec_func:
    # save frame point and return address
    addi $sp, $sp, -8
    sw $fp, 0($sp)
    sw $ra, 4($sp)

    move $fp, $sp # update frame point

    lw $t0, 8($fp) # load argument

    slt $t1, $0, $t0 # check 0 < n  
    beq $t1, $0, terminate # exit function

        # printf("%d\n", n);
        li $v0, 1
        move $a0, $t0
        syscall
        li $v0, 4
        la $a0, new_line
        syscall

        ##### call rec_func(n - 2) ####
        addi $t1, $t0, -2 # find n - 2

        # save register
        addi $sp, $sp, -4
        sw $t0, 0($sp)

        # save argument
        addi $sp, $sp, -4
        sw $t1, 0($sp)

        jal rec_func
        
        # return argument's memory
        addi $sp, $sp, 4

        # restore register
        lw $t0, 0($sp)
        addi  $sp, $sp, 4

        ##### call rec_func(n - 3) ####

        addi $t1, $t0, -3 # find n - 3

        # save register
        addi $sp, $sp, -8
        sw $t0, 0($sp)
        sw $t2, 4($sp)

        # save argument
        addi $sp, $sp, -4
        sw $t1, 0($sp)

        jal rec_func

        # return argument's memory
        addi $sp, $sp, 4

        # restore register
        lw $t0, 0($sp)
        lw $t2, 4($sp)
        addi  $sp, $sp, 8

        #####

        # printf("%d\n", n);
        li $v0, 1
        move $a0, $t0
        syscall
        li $v0, 4
        la $a0, new_line
        syscall

    terminate:

    #restore return address and frame point
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8

    jr $ra

main:

    li $s0, 5 # set argument
    
    # save argument 
    addi $sp, $sp, -4 
    sw $s0, 0($sp)

    jal rec_func

    # restore argument
    addi $sp, $sp, 4

    li $v0, 10
    syscall