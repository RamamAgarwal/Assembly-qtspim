.data

.text
main:
	li $t0, 18
	li $t1, 20
	
	slt $t3, $t0, $t1
	slti $t3, $t0, 3
	
	li $v0, 10
	syscall