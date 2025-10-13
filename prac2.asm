.data
str: .asciiz "Enter a number: "
.text
	main:
		li $v0,4
		la $a0, str
		syscall
		
		li $v0,5
		syscall
		
		move $a0, $v0
		
		li $v0,1
		syscall
		
		li $v0,10
		syscall