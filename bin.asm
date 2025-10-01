.data 

msg: .ascii "Insira um número não negativo: \0"
msg2: .ascii "Invalid number! \0"


.text

# Print msg
li $v0, 4
la $a0, msg
syscall

# Get number
li $v0, 5
syscall

# Move to Andere registriren
move $s0, $v0
move $s1, $v0

blt $s0, $zero, negl ## Verify if is neg

li $s7, 2 # comparation registrieren
move $s2, $zero # counter

jal detem_space  # Calc alloc space in array


li $v0, 9 # Syscall to alloc memory for the array in Heap 
move $a0, $s2
syscall 

move $s6, $v0 # Get pointer in $v0


# Get to the last writable position
subi $t0, $s2, 1
mul $t0, $t0, 4
add $s6, $s6, $t0

jal int_bin

addi $s6, $s6, 4 # The loop make one more negative than should correcting this
li $v0, 1

lp_begin:
	lw $a0, 0($s6)
	syscall
	addiu $s6, $s6, 4
	subi $s2, $s2, 1
	beq $s2, $zero, exit
	j lp_begin

# Exit program
exit: 
	li $v0, 10
	syscall

detem_space:
	bne $s1, $zero, ne  # If sucession division end return
		jr $ra
	ne:
		div $s1, $s7  # Div
		mflo $s1
		addi $s2, $s2, 1 # i++
		
		j detem_space
		
		
int_bin:
	bne $s0, $zero, ne2 # If sucession division end return
		jr $ra
	ne2:
		div $s0, $s7
		mflo $s0
		mfhi $t0
		
		sb $t0, 0($s6) # Save division rest in array
		
		subiu $s6, $s6, 4 # Go to i-- position
		
		#addiu $s6, $s6, 1
		
		j int_bin

negl:
	# Neg Value; print error und exit 
	li $v0, 4
	la $a0, msg2
	syscall
	j exit