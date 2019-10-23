main:
	addu $s1, $zero, $zero # cycle 1
	addu $s3, $zero, $zero # cycle 2
	addiu $sp, $sp, -4 # # cycle 3
	addiu $s0, $0, 5 # cycle 4
	sw $s0, 0($sp) # cycle 5
	jal HAILSTONE # cycle 6
	nop # cycle 7
	addiu $sp, $sp, 4 # cycle 70
	addu $s1, $s1, $v0 # cycle 71
	addiu $sp, $sp, -12 # cycle 72
	sw $s1, 8($sp) # cycle 73
	addiu $s1, $s1, 1 # cycle 74
	sw $s1, 4($sp) # cycle 75
	addiu $s1, $s1, 1 # cycle 76
	sw $s1, 0($sp) # cycle 77
	lw $s2, 8($sp) # cycle 78
	addu $s3, $s2, $zero # cycle 79
	lw $s2, 4($sp) # cycle 80
	addu $s3, $s2, $s3 # cycle 81
	lw $s2, 0($sp) # cycle 82
	addu $s3, $s2, $s3 # cycle 83
	j EXIT # cycle 84
	nop # cycle 85

HAILSTONE:
	addiu $sp, $sp, -8 # cycle 8
	sw $ra, 4($sp) # cycle 9
	sw $fp, 0($sp) # cycle 10
	addu $fp, $sp, $zero # cycle 11
	lw $t0, 8($fp) # cycle 12
	addiu $t1, $zero, 1 # cycle 13
	addu $t2, $zero, $zero # cycle 14
WHILE:
	beq $t0, $t1, WHILE_OUT # cycle 15, 26, 35, 44, 53, 62
	nop # delayed slot # cycle 16, 27, 36, 45, 54, 63
WHILE_IN:
	addiu $t2, $t2, 1 # cycle 17, 28, 37, 46, 55
	andi $t3, $t0, 1 # cycle 18, 29, 38, 47, 56
	bne $t3, $zero, ELSE # cycle 19, 30, 39, 48, 57
	nop # delayed slot # cycle 20, 31, 40, 49, 58
IF:
	sra $t0, $t0, 1 # cycle 32, 41, 50, 59
	j WHILE # cycle 33, 42, 51, 60
	nop # cycle 34, 43, 52, 61
ELSE:
	addu $t4, $t0, $t0 # cycle 21
	addu $t0, $t0, $t4 # cycle 22
	addiu $t0, $t0, 1 # cycle 23
	j WHILE # cycle 24
	nop # cycle 25
WHILE_OUT:
	lw $ra, 4($sp) # cycle 64
	lw $fp, 0($sp) # cycle 65
	addiu $sp, $sp, 8 # cycle 66
	addu $v0, $t2, $zero # cycle 67
	jr $ra # cycle 68
	nop # cycle 69
EXIT:
	nop # cycle 86
	nop # cycle 87
	nop # cycle 88
	nop # cycle 89
	nop # cycle 90