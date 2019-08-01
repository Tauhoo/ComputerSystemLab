
.data # data section
array1: .word 24, 13, 9, -16 # define an array of int containing four elements
array2: .word 8, 7, -11, 3 # define an array of int containing four elements


.text # text section

.globl main # call main by SPIM

main:
la $8, array1 # set array1 address to $8
la $9, array2 # set array2 address to $9

lw $10, 0($8) # get array1[1]
lw $11, 0($9) # get array2[1]

mult $10, $11
mflo $12


lw $10, 4($8) # get array1[1]
lw $11, 4($9) # get array2[1]

mult $10, $11
mflo $10
add $12, $10, $12

lw $10, 8($8) # get array1[1]
lw $11, 8($9) # get array2[1]

mult $10, $11
mflo $10
add $12, $10, $12

lw $10, 12($8) # get array1[1]
lw $11, 12($9) # get array2[1]

mult $10, $11
mflo $10
add $12, $10, $12

move $a0, $12
li $v0, 1
syscall

li	$v0, 10
syscall
