.data

.text
main:
	li $t1, 1
	sll $t0, $t1, 2 #shift left logical 

	move $a0, $t0
	
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
