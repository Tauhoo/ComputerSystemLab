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

	addiu $sp, $sp, 4 #set stack back

	j EXIT
	nop
	nop
#HAILSTONE need one argument hailstone(int n)
HAILSTONE:
	addiu $sp, $sp, -8
	nop
	nop
	nop
	sw $ra, 4($sp) #store add address of $ra
	sw $fp, 0($sp) #store address of $fp
	addu $fp, $sp, $zero
	nop
	nop
	nop
	lw $s0, 8($fp) #load argument n
	addiu $s1, $zero, 1
	#we will use i store at $s2
	addu $s2, $zero, $zero
	#check n != 1
WHILE:
	nop
	nop
	beq $s0, $s1, WHILE_OUT
	nop
	nop
WHILE_IN:
	 #n!=1 WHITE_IN:WHILE_OUT
	addiu $s2, $s2, 1 #i+i+1
	#n %2 == n&1
	nop
	nop
	andi $s3, $s0, 1 #n&1 == n%2
	nop
	nop
	nop
	bne $s3, $zero, ELSE #if(n%2)==0
	nop
	nop
IF:
	#n/2
	sra $s0, $s0, 1 #n = n/2
	j WHILE
	nop
	nop
ELSE:
	nop
	addu $s4, $s0, $s0 #$s4 = 2*n
	nop
	nop
	nop
	addu $s0, $s0, $s4 #n = 2*n +n = 3*n
	nop
	nop
	nop
	addiu $s0, $s0, 1 #n = 3*n+1
	j WHILE
	nop
	nop

WHILE_OUT:
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 8
	addu $a0, $s2, $zero #return i
	jr $ra
	nop
	nop

EXIT:
	#just exit we must use syscall
	#but it can't
	#we will just move a0 to t0
	addu $t0, $a0, $zero
