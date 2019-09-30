#$8 must be 16 ( 0x10 )
main:
	#init
	addu $sp, $zero, $zero
	addu $ra, $zero, $zero

	nop
	nop
	addiu $sp, $sp, -4 #for n argument
	#you can change this line to whatever you want
	addiu $t0, $zero, 7
	nop
	nop
	nop
	sw $t0, 0($sp)

	jal HAILSTONE
	nop
	nop

	j EXIT
	nop
	nop
# hailstone(int n) need one argument
HAILSTONE:
	addiu $sp, $sp, -8
	nop
	nop
	nop
	sw $ra, 4($sp) #store add address of$ra
	sw $fp, 0($sp) #store address of $fp
	addu $fp, $sp, $zero
	nop
	nop
	nop
	lw $s0, 8($fp) #load argument n
	addiu $s1, $zero, 1 # 1
	nop
	nop
	nop
	#if n==1 return 0
	beq $s0, $s1, RETURN_ZERO
	nop
	nop
	#n%2 = n&(2-1) = n&1
	andi $s2, $s0, 1
	nop
	nop
	nop
	#if (n%2) == 0
	beq $s2, $zero, RETURN_L1
	#else
	nop
	nop
RETURN_L2:
	#load next function
	#we need to assign new n/2
	addiu $sp, $sp, -4
	#we know $s0 is n and we need to make n+1
	addu $s4, $s0, $s0 #n*2
	nop
	nop
	nop
	addu $s4, $s4, $s0 #n*2+n = 3*n
	nop
	nop
	nop
	addiu $s4, $s4, 1 #n+1
	nop
	nop
	nop
	sw $s4, 0($sp) #store augment
	jal HAILSTONE #recursive
	nop
	nop
	#when it out
	#we don't need n anymore and don't need to load for use
	addiu $sp, $sp, 4
	nop
	nop
	nop
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	addiu $sp, $sp, 8
	addiu $a0, $a0, 1 #return 1+recusive
	jr $ra
	nop
	nop
RETURN_ZERO:

	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 8
	#we will use a0 to return this function
	addiu $a0, $a0, 0 #return 0
	jr $ra
	nop
	nop

RETURN_L1:
	#load next function
	#we need to assign new n/2
	addiu $sp, $sp, -4
	#we know $s0 is n and we need to make n/2 use SRA
	sra $s3, $s0, 1 #n/2
	nop
	nop
	nop
	sw $s3, 0($sp) #store augment
	jal HAILSTONE #recursive
	nop
	nop
	#when it out
	#we don't need n anymore and don't need to load for use
	addiu $sp, $sp, 4
	nop
	nop
	nop
	lw $ra, 4($sp)
	lw $fp, 0($sp)

	addiu $sp, $sp, 8
	addiu $a0, $a0, 1 #return 1+recursive
	jr $ra
	nop
	nop
EXIT:
	#just exit we must use syscall
	#but it can't
	#we will just move a0 to t0
	addu $t0, $a0, $zero
