.data
msg: .asciiz "Factorial = "

.text
main:
	li $a0, 5	# n=5
	jal factorial	# Call factorial
	move $s0, $v0	# Save result in $s0
	
	# Print Result
	li $v0,4
	la $a0, msg
	syscall
	
	move $a0, $s0
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
	
#factorial(n):
#if n<=1 return 1
#else return n*factorial(n-1)

factorial:
	addi $sp, $sp, -8	#Make space for 2 items
	sw $ra, 4($sp)	#Save return address
	sw $a0, 0($sp)	#Save argument n

	ble $a0, 1, base_case # if n<=0 return 1
	
	addi $a0, $a0, -1 #n-1
	jal factorial	#recursive call
	
	lw $a0, 0($sp) # restore original n
	mul $v0, $a0, $v0	# n * factorial(n-1)
	
	j end_fact
	
base_case:
	li $v0, 1	# return 1
	
end_fact:
	lw $ra, 4($sp)	# Restore return address
	addi $sp, $sp, 8	# Pop stack frame
	jr $ra		# Return