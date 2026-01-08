.data
str: .asciiz "Enter the value of N: "
str1: .asciiz "Sum of N natural no.s: "
.text
	main:
		li $v0,4
		la $a0,str
		syscall
		
		li $v0,5
		syscall
		move $t0,$v0
		
		li $t1,1
		li $t2,0
		
		func:
			bgt $t1,$t0,end
		
			add $t2,$t1,$t2
			addi $t1,1
			
			j func
		
		end:
			li $v0,4
			la $a0,str1
			syscall
			
			li $v0,1
			move $a0,$t2
			syscall
			
			li $a0,10
			li $v0,11
			syscall
			
			li $v0,10
			syscall
			
	