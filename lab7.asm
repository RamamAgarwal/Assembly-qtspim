 .data

 .text
 main:
	li $t0, 2
	li $t1, 7
	
	div $t1, $t0
	
	mflo $t2
	move $a0, $t2
	li $v0, 1
	syscall
	
	mfhi $a0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall