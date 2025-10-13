.data
msg_push: .asciiz "Pushing onto stack...\n"
msg_pop:  .asciiz "Popping from stack...\n"
newline:  .asciiz "\n"

.text

main:
    # Print push message
    li $v0, 4
    la $a0, msg_push
    syscall
    
    # Push 10
    li $t0, 10
    addi $sp, $sp, -4     # decrement stack pointer
    sw $t0, 0($sp)        # store 10 on stack

    # Push 20
    li $t0, 20
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    # Push 30
    li $t0, 30
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    # Print pop message
    li $v0, 4
    la $a0, msg_pop
    syscall

    lw $t1, 0($sp)        # load top element (30)
    addi $sp, $sp, 4      # move stack pointer up
    li $v0, 1             # print integer
    move $a0, $t1
    syscall

    li $v0, 4             # newline
    la $a0, newline
    syscall

    lw $t1, 0($sp)        # load next element (20)
    addi $sp, $sp, 4
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    lw $t1, 0($sp)        # load next element (10)
    addi $sp, $sp, 4
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
