# ----------------------------------------
# MIPS Program: Linked List Insertion
# Operation: Insert a new node at the end
# ----------------------------------------

.data
prompt:     .asciiz "Enter a number to insert (-1 to stop): "
newline:    .asciiz "\n"
msg_list:   .asciiz "Linked List: "
space:      .asciiz " "

# Pointers
head:       .word 0            # pointer to first node
temp:       .word 0            # temporary pointer
current:    .word 0            # for traversal

.text
.globl main

main:
    la $t0, head               # load address of head
    sw $zero, 0($t0)           # initialize head = NULL

insert_loop:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $t1, $v0              # t1 = input value

    # Exit condition (-1)
    li $t2, -1
    beq $t1, $t2, print_list

    # Allocate dynamic memory for new node (8 bytes)
    li $v0, 9                  # sbrk syscall
    li $a0, 8
    syscall
    move $t3, $v0              # t3 = new node address

    # Store data
    sw $t1, 0($t3)             # node->data = input
    sw $zero, 4($t3)           # node->next = NULL

    # If head == NULL, set head = new node
    lw $t4, 0($t0)
    beq $t4, $zero, set_head

    # Otherwise, traverse to end
    move $t5, $t4              # t5 = current = head
traverse:
    lw $t6, 4($t5)             # t6 = current->next
    beq $t6, $zero, insert_end # if next == NULL, insert here
    move $t5, $t6              # current = current->next
    j traverse

insert_end:
    sw $t3, 4($t5)             # current->next = new node
    j insert_loop

set_head:
    sw $t3, 0($t0)             # head = new node
    j insert_loop


# -----------------------------
# Print the Linked List
# -----------------------------
print_list:
    li $v0, 4
    la $a0, msg_list
    syscall

    lw $t7, 0($t0)             # t7 = head
print_loop:
    beq $t7, $zero, exit       # if NULL, done
    lw $a0, 0($t7)             # print node->data
    li $v0, 1
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    lw $t7, 4($t7)             # t7 = node->next
    j print_loop

exit:
    li $v0, 10
    syscall
