.data
prompt1: .asciiz "Enter first integer: "
prompt2: .asciiz "Enter second integer: "
result:  .asciiz "The product is: "

.text

main:

    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5       
    syscall
    move $t0, $v0     

    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0      

    jal product              

    li $v0, 4
    la $a0, result
    syscall
	
	move $a0, $t3

    li $v0, 1								
    syscall

    li $v0, 10
    syscall
	
product:
	mul $t3, $t0, $t1
    jr $ra
