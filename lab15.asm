.data
abc: .word 10, 20, 30, 40
.text
main:
	la $t0,abc
	lw $t1, 0($t0)
	lw $t2, 4($t0)
	lw $t3, 8($t0)
	lw $t4, 12($t0)
	
	li $v0, 10
	syscall