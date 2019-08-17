.data # data section

new_line: .asciiz "\n"
Expo1: .asciiz "Expo1 result: "
Expo2: .asciiz "Expo2 result: "
Expo3: .asciiz "Expo3 result: "

.text # text section

.globl main # call main by SPIM

expo1:
    # save frame point and return address
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    move $fp, $sp # update frame point

    lw $t0, 8($sp) # declare x
    lw $t1, 12($sp) # declare n

    li $t2, 0 # i = 0
    li $t3, 1 # result = 1

    multiply:
        slt $t4, $t2, $t1 # check if i < n
        beq $t4, $0, exit_multiply # beak from loop

        mult $t3, $t0 # result * x

        mflo $t3 # x = result * x

        addi $t2, $t2, 1 # i++
        j multiply
    exit_multiply:

    # return stack and fp
    lw $fp, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    move $v0, $t3 # return result 

    jr $ra


expo2:
    # save frame point and return address
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    move $fp, $sp # update frame point

    lw $t0, 8($fp) # declare x
    lw $t1, 12($fp) # declare n

    beq $t1, $0, last # jump if n == 1

        addi $t1 , $t1, -1 # n = n-1

        # caller save register
        addi $sp, $sp, -4
        sw $t0, 0($sp)

        # save argument
        addi $sp, $sp, -8
        sw $t0, 0($sp)
        sw $t1, 4($sp)

        jal expo2 # call itself

        # return memory of argument
        addi $sp, $sp, 8

        # caller save register
        lw $t0, 0($sp)
        addi $sp, $sp, 4

        mult $v0, $t0 # expo2(x, n - 1) * x

        mflo $v0 # return expo2(x, n - 1) * x 
        
        j return_value

    last:
        li $v0, 1 # return 1

    return_value:

    # restore return address and frame
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8

    jr $ra

expo3:
    # save frame point and return address
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    move $fp, $sp

    lw $t0, 8($sp) # declare x
    lw $t1, 12($sp) # declare n

    beq $t1, $0, return_one # if n == 0 

        ##### call function expo3 first time #####

        # fh = expo3(x, n / 2)

        srl $t2, $t1, 1 # store n/2 to $t2

        # save register caller save
        addi $sp, $sp, -8
        sw $t0, 0($sp) # save x
        sw $t1, 4($sp) # save n

        # save argument 
        addi $sp, $sp, -8
        sw $t0, 0($sp) # save x
        sw $t2, 4($sp) # save n/2

        jal expo3 # call expo3

        # return memory of argument
        addi $sp, $sp, 8

        # restore register
        lw $t0, 0($sp)
        lw $t1, 4($sp)
        addi $sp, $sp, 8

        move $t3, $v0 # set result to fh ($t3)

        ##### end expo3 call #####

        ##### call function expo3 second time #####

        # fh = expo3(x, n / 2)

        srl $t2, $t1, 1 # store n/2 to $t2

        # save register caller save
        addi $sp, $sp, -12
        sw $t0, 0($sp) # save x
        sw $t1, 4($sp) # save n
        sw $t3, 8($sp) # save $t3

        # save argument 
        addi $sp, $sp, -8
        sw $t0, 0($sp) # save x
        sw $t2, 4($sp) # save n

        jal expo3 # call expo3

        # return memory of argument
        addi $sp, $sp, 8

        # restore register
        lw $t0, 0($sp)
        lw $t1, 4($sp)
        lw $t3, 8($sp)
        addi $sp, $sp, 12

        move $t4, $v0 # set result to sh ($t3)

        ##### end expo3 call #####

        # find n % 2
        li $t5, 1 # set checker to 1
        and $t5, $t1, $t5 # n % 2 


        beq $t5, $0, return_three # check if n % 2 == 0

            mult $t3, $t4 # fh * sh

            mflo $t5

            mult $t0, $t5 # fh * sh * x

            mflo $v0 # return fh * sh * x


            j end_if2

        return_three:

            mult $t3, $t4 # fh * sh

            mflo $v0 # return fh * sh

        end_if2:

        j end_if3

    return_one:

        li $v0, 1 # return 1

    end_if3:

    # restore frame point and return address
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8

    jr $ra

main:

    ##### printf("Expo1 result: ");
    la $a0, Expo1
    li $v0, 4
    syscall

    #set argumentx, n
    li $s0, 4
    li $s1, 7

    # save argument to stack
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal expo1

    #return stack
    addi $sp, $sp, 8

    # print returned value
    move $a0, $v0
    li $v0, 1
    syscall
    la $a0, new_line
    li $v0, 4
    syscall

    ##### printf("Expo2 result: ");
    la $a0, Expo2
    li $v0, 4
    syscall

    #set argumentx, n
    li $s0, 4
    li $s1, 7

    # save argument to stack
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal expo2

    #return stack
    addi $sp, $sp, 8

    # print returned value
    move $a0, $v0
    li $v0, 1
    syscall
    la $a0, new_line
    li $v0, 4
    syscall

    ##### printf("Expo3 result: ");
    la $a0, Expo3
    li $v0, 4
    syscall

    #set argumentx, n
    li $s0, 4
    li $s1, 7

    # save argument to stack
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    jal expo3

    #return stack
    addi $sp, $sp, 8

    # print returned value
    move $a0, $v0
    li $v0, 1
    syscall
    la $a0, new_line
    li $v0, 4
    syscall

	# exit
	li $v0, 10
	syscall
