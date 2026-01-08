  .data
  str: .asciiz "Enter 1st number: "
  str1: .asciiz "Enter 2nd number: "
  str2: .asciiz "Sum of 2 numbers: "
  
  .text
  main:
	la $a0,str # loading the address of str in a0
	
	li $v0,4 # printing the first string 
	syscall
	
	li $v0,5 # loading the first integer
	syscall
	
	move $t0,$v0 # moving the value from v0 to t0
	
    la $a0,str1
	
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $t1,$v0
	
	add $t2, $t0, $t1
	
	la $a0,str2
	
	li $v0,4
	syscall
	
	move $a0,$t2
	
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
	