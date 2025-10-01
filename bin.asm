.data 

msg: .ascii "Insira um número não negativo: "


byte_size: .float 4

.text

# Print msg
li $v0, 4
la $a0, msg

# Get number
li $v0, 5
syscall

# Move to Andere registriren
move $s0, $v0
move $s1, $v0

li $s7, 2 # comparation registrieren
move $s2, $zero # counter

jal detem_space

mtc1 $s2, $f0 # Convert the nessary space in Bytes to float

l.d $f2, byte_size # Byte size

div.d $f4, $f2, $f0

li $v0, 9 # Syscall to alloc memory for the array in Heap 




# Exit program
exit: 
	li $v0, 10
	syscall

detem_space:
	bne $s1, $zero, ne
		jr $ra
	ne:
		div $s1, $s7
		mflo $s1
		addi $s2, $s2, 1
		
		j detem_space