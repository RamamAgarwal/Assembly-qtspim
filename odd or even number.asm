.data
str: .asciiz "Enter a number: "
str1: .asciiz "Odd number"
str2: .asciiz "Even number"
.text
	main:
		li $t2,2
		
		li $v0,4
		la $a0,str
		syscall
		
		li $v0,5
		syscall
		
		move $t0,$v0
		
		div $t0, $t2
		mfhi $t1
		
		beq $t1, $zero, even
		
		li $v0,4
		la $a0,str1
		syscall
		
		li $a0,10
		li $v0,11
		syscall
		
		j main
		
		even:
			li $v0,4
			la $a0,str2
			syscall
			
			li $a0,10
			li $v0,11
			syscall
			
			j main
