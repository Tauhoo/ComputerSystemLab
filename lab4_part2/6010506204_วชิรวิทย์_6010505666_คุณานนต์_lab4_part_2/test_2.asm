main:
	addu $s1, $zero, $zero # cycle 1
 	addu $s3, $zero, $zero # cycle 2
	addiu $sp, $sp, -4 # cycle 3
	addiu $s0, $0, 5 # cycle 4
	jal HAILSTONE # cycle 5
	sw $s0, 0($sp) # delay slot # cycle 6
	addiu $sp, $sp, 4 # cycle 53
	addu $s1, $s1, $v0 # cycle 54
	addiu $sp, $sp, -12 # cycle 55
	sw $s1, 8($sp) # cycle 56
	addiu $s1, $s1, 1 # cycle 57
	sw $s1, 4($sp) # cycle 58
	addiu $s1, $s1, 1 # cycle 59
	sw $s1, 0($sp) # cycle 60
	lw $s2, 8($sp) # cycle 61
	addu $s3, $s2, $zero # cycle 62
	lw $s2, 4($sp) # cycle 63
	addu $s3, $s2, $s3 # cycle 64
	lw $s2, 0($sp) # cycle 65
	j EXIT # cycle 66
	addu $s3, $s2, $s3  # delay slot # cycle 67

HAILSTONE:
	addiu $sp, $sp, -8 # cycle 7
	sw $ra, 4($sp) # cycle 8
	sw $fp, 0($sp) # cycle 9 
	addu $fp, $sp, $zero # cycle 10
	lw $t0, 8($fp) # cycle 11
	addiu $t1, $zero, 1 # cycle 12
	addu $t2, $zero, $zero # cycle 13
WHILE:
	beq $t0, $t1, WHILE_OUT # cycle 14, 22, 28, 34, 40, 46
WHILE_IN:
	andi $t3, $t0, 1 # delay slot # cycle 15, 23, 29, 35, 41, 47
	bne $t3, $zero, ELSE # cycle 16, 24, 30, 36, 42
	addiu $t2, $t2, 1 # delay slot # cycle 17, 25, 31, 37, 43
IF:
	j WHILE # cycle 26, 32, 38, 44
	sra $t0, $t0, 1 # delay slot # cycle 27, 33, 39, 45
ELSE:
	addu $t4, $t0, $t0 # cycle 18
	addu $t0, $t0, $t4 # cycle 19
	j WHILE # cycle 20
	addiu $t0, $t0, 1  # delay slot # cycle 21
WHILE_OUT:
	lw $ra, 4($sp) # cycle 48
	lw $fp, 0($sp) # cycle 49
	addiu $sp, $sp, 8 # cycle 50
	jr $ra # cycle 51
	addu $v0, $t2, $zero # delay slot # cycle 52
EXIT:
    nop # cycle 68
	nop # cycle 69
	nop # cycle 79
	nop # cycle 71
	nop # cycle 72