.data
	.align 4
input:  .asciiz "\nEnter number of disks>>>>>"
move_d:	.asciiz "Move disk: "
from:	.asciiz " from peg: "
to:	.asciiz " to peg: "
new_line: .asciiz ".\n"
DONE: .asciiz "\nPuzzle completed successfully.\n "
 
.text
main:
	add $fp, $zero, $sp 	
    li $v0,4			
    la $a0,input		
    syscall 		
 
	li $v0,5		
    syscall 			
 
	add $a0, $zero, $v0 	
	addi $a1, $zero, 1 		# peg 1
	addi $a2, $zero, 2 		# peg 2
	addi $a3, $zero, 3 		# peg 3
	jal hanoi 			
 
Exit:
	li 	$v0, 4       		
	la 	$a0, DONE    			
	syscall 
        li 	$v0,10			
        syscall                      
		
hanoi:
	#initializing a stack 
	addi	$sp,$sp,-4 		
	sw	$ra,($sp) 		
	addi	$sp,$sp,-4 		
	sw	$fp,($sp) 		
	addi	$sp,$sp,-4 		
	sw	$s0,($sp) 		
	addi	$sp,$sp,-4 		
	sw	$s1,($sp) 		
	addi	$sp,$sp,-4 		
	sw	$s2,($sp) 		
	addi	$sp,$sp,-4 		
	sw	$s3,($sp) 		
	addi	$sp,$sp,-4 		
	addi	$fp, $sp, 32		
	
	#pgm starts : if n != 0 continue 
	beq	$a0, $zero, n_zero 	# is n zero
	sw	$a0,($sp) 		# a0 = "n" on stack
	addi	$sp,$sp,-4 		
	sw	$a1,($sp) 		# a1 = "start"
	addi	$sp,$sp,-4 	
	sw	$a2,($sp) 		# a2 = "finish" 
	addi	$sp,$sp,-4 		
	sw	$a3,($sp) 		# a3 = "extra"
	addi	$sp,$sp,-4 			
	addi	$a0,$a0,-1		# n-1
	
	# swap eg: hanoi(int n, int start, int finish, int extra) => hanoi(n-1, start, extra, finish)
	add	$t2, $zero,$a2 		
	add	$a2, $zero, $a3 	
	add	$a3, $zero, $t2 		
	jal	hanoi		

	addi	$sp,$sp,4 			
	lw	$s0,($sp)		# get "extra" =s0
	addi	$sp,$sp,4 		
	lw	$s1,($sp)		# get "finish" =s1
	addi	$sp,$sp,4 			
	lw	$s2,($sp)		# get "start" =s2
	addi	$sp,$sp,4 			
	lw	$s3,($sp)		# get n =s3
 
	# print "Move disk (n) from peg (start) to peg (finish)\n"
	li 	$v0, 4        			
	la 	$a0, move_d     			
	syscall 
	li 	$v0,1  
    add $a0, $zero, $s3                      
	syscall 
	li 	$v0, 4        		
	la 	$a0, from     		
	syscall 
	li 	$v0, 1        			
	add $a0,$zero, $s2     			
	syscall 
	li 	$v0, 4        			
	la 	$a0, to     			
	syscall 
	li 	$v0, 1        			
	add $a0, $zero, $s1     			
	syscall 
	li 	$v0, 4        			
	la 	$a0, new_line     			
	syscall 

	
	addi 	$a0,$s3,-1		# put n-1 in arg 0
	add 	$a1, $zero, $s0 	# extra is second arg 
	add 	$a2, $zero, $s1 	# finish is third arg
	add 	$a3, $zero, $s2 	# start is last arg 
	jal 	hanoi 		
	
n_zero:
	addi	$sp,$sp,4 		 
		lw	$s3,($sp) 		
	addi	$sp,$sp,4 	
		lw	$s2,($sp) 		
	addi	$sp,$sp,4 		
		lw	$s1,($sp) 		
	addi	$sp,$sp,4 		
		lw	$s0,($sp) 		
	addi	$sp,$sp,4 	
		lw	$fp,($sp) 		
	addi	$sp,$sp,4 		
		lw	$ra,($sp) 		
	addi	$sp,$sp,4 		
	jr 	$ra 	