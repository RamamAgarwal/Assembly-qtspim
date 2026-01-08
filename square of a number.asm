.data
str: .asciiz "Enter a number: "
.text
	main:
		li $v0,4
		la $a0,str
		syscall
		
		li $v0,5
		syscall
		
		move $t0,$v0
		
		mul $t0, $t0, $t0
		
		move $a0,$t0
		
		li $v0,1
		syscall
		
		li $v0,10
		syscall