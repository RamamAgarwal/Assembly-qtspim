.data
 str: .asciiz "Enter 1st number: "
 str1: .asciiz "Enter 2nd number: "
 str2: .asciiz "Sum of 2 numbers: "
 newline: .asciiz "\n" 
.text
main:
	la $a0,str
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
    la $a0,str1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	la $a0,str2
	li $v0,4
	syscall
	
	bne $t0, $t1, add_func
	li $v0,10
	syscall
	
	add_func:
	add $t2, $t0, $t1
	move $a0,$t2
	
	li $v0,1
	syscall
	
	li $a0,10
	li $v0,11
	syscall
	
	la $a0,newline
	li $v0,4
	syscall
	
	j main