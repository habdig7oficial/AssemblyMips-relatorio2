.data
msg1: .ascii "Insira um número não negativo: \0"
msg2: .ascii "Invalid number! \0"

terminator: .ascii "\n\0"

.text

main:
# Print str
li $v0, 4
la $a0, msg1
syscall

# Get Integer
li $v0, 5
syscall

# Set registers
move $s0, $v0
move $s1, $v0

# set base factorial value
li $s7, 1
move $s2, $s7

# Validate negative
blt $s0, $zero, negl

# Jump to function
jal fact

li $v0, 4
la $a0, terminator
syscall

li $v0, 1
move $a0, $s2
syscall

exit:
li $v0, 10
syscall

fact:
# while $s1 > 0:
bne $s1, $zero, iter
jr $ra # Return
iter:
# --

# Do factorial operations
mul $s2, $s1, $s2

sub $s1, $s1, $s7

j fact # Continue loop

negl:
# Neg Value; print error und exit 
li $v0, 4
la $a0, msg2
syscall
j exit
