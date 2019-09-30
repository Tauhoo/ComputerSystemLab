
addiu $sp, $sp, -8
addiu $s1, $zero, 0x4
addiu $s0, $zero, 0x5
nop
nop
nop

sw $s1, 4($sp)
sw $s0, 0($sp)

jal SUM
nop
nop
addu $s2, $zero, $a0

addiu $sp, $sp, 8
j EXIT 
nop
nop

SUM:
    addiu $sp, $sp, -8
    nop
    nop
    nop
    sw $ra, 4($sp)
    sw $fp, 0($sp)

    addu $fp, $sp, $zero
    nop
    nop
    nop
    lw $t0, 8($fp)
    lw $t1, 12($fp)
    nop
    nop
    nop
    addu $a0, $t0, $t1

    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addiu $sp, $sp, 8

    jr $ra
    nop

EXIT:
