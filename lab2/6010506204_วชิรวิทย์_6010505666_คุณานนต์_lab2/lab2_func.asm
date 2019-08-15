.data # data section

new_line: .asciiz "\n"
result: .asciiz "Result = "

.text # text section

.globl main # call main by SPIM

min_three:
    addi $sp, $sp, -8 # move stack
	sw $ra, 4($sp) # store return address
	sw $fp, 0($sp) # store last frame point address

    addu $fp, $0, $sp # fetch new frame point address

    lw $t0, 8($fp) # get first argument
    lw $t1, 12($fp) # get second argument
    lw $t2, 16($fp) # get third argument

    slt $t3, $t0, $t1 # check if $t0 < $t1
    beq $t3, $0, set_t1
        add $t0, $t0, $0 # set $t0 as lowest value
        j out_if1 # exit if statement
    set_t1:
        add $t0, $t1, $0 # set $t1 as lowest value
    out_if1:

    slt $t3, $t0, $t2 # check if $t0 < $t2
    beq $t3, $0, set_t2 
        add $v0, $t0, $0 # set $t0 as lowest value
        j out_if2
    set_t2:
        add $v0, $t2, $0 # set $t2 as lowest value
    out_if2:

    lw $ra, 4($fp) # load return address
    lw $fp, 0($fp) # load last frame point value
    addi $sp, $sp, 8 # return stack

    jr $ra # exit function

max_three:
    addi $sp, $sp, -8 # move stack
	sw $ra, 4($sp) # store return address
	sw $fp, 0($sp) # store last frame point address

    addu $fp, $0, $sp # fetch new frame point address

    lw $t0, 8($sp) # get first argument
    lw $t1, 12($sp) # get second argument
    lw $t2, 16($sp) # get third argument

    slt $t3, $t0, $t1 # check if $t0 < $t1
    beq $t3, $0, mset_t1
        add $t0, $t1, $0 # set $t1 as lowest value
        j mout_if1 # exit if statement
    mset_t1:
        add $t0, $t0, $0 # set $t0 as lowest value
    mout_if1:

    slt $t3, $t0, $t2 # check if $t0 < $t2
    beq $t3, $0, mset_t2
        add $v0, $t2, $0 # set $t2 as lowest value
        j mout_if2 # exit if statement
    mset_t2:
        add $v0, $t0, $0 # set $t0 as lowest value
    mout_if2:

    lw $ra, 4($fp) # load return address
    lw $fp, 0($fp) # load last frame point value
    addi $sp, $sp, 8 # return stack

    jr $ra # exit function

foo:
    addi $sp, $sp, -8 # move stack pointer
    sw $ra, 4($sp) # store return address
    sw $fp, 0($sp) # store last frame point 

    add $fp, $sp, $0 #

    lw $t0, 8($fp) # load x argument
    lw $t1, 12($fp) # load y argument

    li $t2, 0xbeef # initialize z variable

    # y^z
    xor $t5, $t1, $t2

    # x^z 
    xor $t6, $t0, $t2 

    # y^x
    xor $t7, $t1, $t0

    #debug
    #add $a0, $t5, $0
    #li $v0, 1
    #syscall
    #la $a0, new_line
    #li $v0, 4
    #syscall

    #add $a0, $t6, $0
    #li $v0, 1
    #syscall
    #la $a0, new_line
    #li $v0, 4
    #syscall

    #add $a0, $t7, $0
    #li $v0, 1
    #syscall
    #la $a0, new_line
    #li $v0, 4
    #syscall

    #call max_three

    addi $sp, $sp, -12 # move stack pointer  
    sw $t5, 0($sp) # save first register
    sw $t6, 4($sp) # save second register
    sw $t7, 8($sp) # save third register

    addi $sp, $sp, -12 # move stack for argument
    sw $t5, 0($sp) # save first argument
    sw $t6, 4($sp) # save second argument
    sw $t7, 8($sp) # save third argument

    jal max_three
    
    lw $t5, 0($sp) # return first register
    lw $t6, 4($sp) # return second register
    lw $t7, 8($sp) # return third register
    addi $sp, $sp, 12 # return stack pointer
    addi $sp, $sp, 12 # return stack for argument

    add $t4, $0, $v0 # store max_three result

    #call min_three
    addi $sp, $sp, -16 # move stack pointer  
    sw $t5, 0($sp) # save first register
    sw $t6, 4($sp) # save second register
    sw $t7, 8($sp) # save third register
    sw $t4, 12($sp) # save result from max_three

    addi $sp, $sp, -12 # move stack for argument
    sw $t5, 0($sp) # save first argument
    sw $t6, 4($sp) # save second argument
    sw $t7, 8($sp) # save third argument

    jal min_three
    
    lw $t5, 0($sp) # return first register
    lw $t6, 4($sp) # return second register
    lw $t7, 8($sp) # return third register
    lw $t4, 12($sp) # return result from max_three to register
    addi $sp, $sp, 12 # return stack for argument
    addi $sp, $sp, 16 # return stack for register

    add $t4, $0, $v0 # store min_three result

    add $v0, $t4, $0 # return result value to $v0 

    lw $ra, 4($fp)
    lw $fp, 0($fp)

    addi $sp, $sp, 8
    jr $ra #  exit function


main:

    li $a0, 0xabcd
    li $a1, 0xdead

    addi $sp, $sp, -8
    sw $a0, 0($sp) #
    sw $a1, 4($sp) #

    jal foo 

    addi $sp, $sp, 8

    add $s0, $v0, $0 #store return value

    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    add $a0, $s0, $0
    syscall

    li $v0, 4
    la $a0, new_line
    syscall
    

	# exit
	li $v0, 10
	syscall
