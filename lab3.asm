.data
.text
main:
	li $t0,2
	li $t1,10
	add $a0, $t0, $t1 # just that storing the result in accumulator
	  
	li $v0, 10
	syscall