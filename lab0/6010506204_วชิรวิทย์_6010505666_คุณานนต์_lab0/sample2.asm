
.data # data section
array1: .word 100, 200, 300, 400 # define an array of int containing four elements
array2: .word 10, 20, 30, 40 # define an array of int containing four elements
array3: .word 0, 0, 0, 0 # define an array of int containing four elements

.text # text section

.globl main # call main by SPIM

main:
la $8, array1 # set array1 address to $8
la $9, array2 # set array2 address to $9
la $10, array3 # set array3 address to $10

lw $11, 0($8) # set array1[0] to register $11
lw $12, 0($9) # set array2[0] to register $12
add $12, $11, $12 # $12 = $11 + $12
sw $12, 0($10) # array3[0] = $12

lw $11, 4($8) # set array1[1] to register $11
lw $12, 4($9) # set array2[1] to register $12
add $12, $11, $12 # $12 = $11 + $12
sw $12, 4($10) # array3[1] = $12

lw $11, 8($8) # set array1[2] to register $11
lw $12, 8($9) # set array2[2] to register $12
add $12, $11, $12 # $12 = $11 + $12
sw $12, 8($10) # array3[2] = $12

lw $11, 12($8) # set array1[2] to register $11
lw $12, 12($9) # set array2[2] to register $12
add $12, $11, $12 # $12 = $11 + $12
sw $12, 12($10) # array3[2] = $12

li	$v0, 10
syscall
