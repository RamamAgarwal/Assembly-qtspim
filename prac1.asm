.data
strname: .asciiz "Enter your name: "
str: .asciiz "My name is "
buffer: .space 100
.text
	main:
		li $v0,4
		la $a0, strname
		syscall
		
		li $v0,8
		la $a0, buffer
		la $a1, 100
		syscall
		
		li $v0,4
		la $a0, str
		syscall
		
		li $v0,4
		la $a0, buffer
		syscall
		
		li $v0,10
		syscall