.data

.text
main:
	addi $sp, $sp, -4
	li $t0, 10
	sw $t0, 0($sp) #special pointer register which points to the top of the stack here
	
	lw $t1, 0($sp)
	
	li $v0, 10
	syscall