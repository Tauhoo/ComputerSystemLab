
addiu $sp, $sp, -8
addiu $s1, $zero, 0x4
addiu $s0, $zero, 0x5

sw $s1, 4($sp)
sw $s0, 0($sp)

jal SUM
nop
addu $s2, $zero, $a0

addiu $sp, $sp, 8
j EXIT 
nop

SUM:
    addu $1, $0, $ra
    addiu $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    addu $fp, $sp, $zero
    lw $t0, 8($fp)
    lw $t1, 12($fp)

    addu $a0, $t0, $t1

    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addiu $sp, $sp, 8

    jr $ra
    nop

EXIT:
