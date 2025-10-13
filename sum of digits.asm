.data
str: .asciiz "Enter a number: "
.text
	main:
		li $t1,10
		
		li $v0,4
		la $a0,str
		syscall
		
		li $v0,5
		syscall
		
		move $t0,$v0
		li $t3,0
		
		loop:
			div $t0, $t1
			mflo $t0
			mfhi $t2
			add $t3, $t2, $t3
			bne $t0, $zero, loop
		
		move $a0, $t3
		li $v0,1
		syscall
		li $v0,10
		syscall
		
			
		