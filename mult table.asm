.data
prompt: .asciiz "Enter a number: "
newline: .asciiz "\n"

.text
main:
    
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0       # store number in $t0

    li $t1, 1           # counter = 1

table_loop:
    ble $t1, 10, print_line
    j exit

print_line:
    mul $t2, $t0, $t1   # result = num * counter

    # Print result
    li $v0, 1
    move $a0, $t2
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    addi $t1, $t1, 1    # counter++
    j table_loop

exit:
    li $v0, 10
    syscall
