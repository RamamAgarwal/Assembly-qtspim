# ----------------------------------------
# MIPS Program: Linked List Insertion After a Specific Index (Using Pointers)
# ----------------------------------------

.data
prompt_value:  .asciiz "Enter a number to insert (-1 to stop): "
prompt_pos:    .asciiz "Insert after which node index (0-based)? "
msg_list:      .asciiz "\nLinked List: "
newline:       .asciiz "\n"
space:         .asciiz " "
head:          .word 0          # pointer to head node (NULL initially)
count:         .word 0          # total node count

.text
.globl main

main:
    la $t0, head
    sw $zero, 0($t0)            # head = NULL
    la $t1, count
    sw $zero, 0($t1)            # count = 0

insert_loop:
    # Prompt user for data
    li $v0, 4
    la $a0, prompt_value
    syscall

    li $v0, 5
    syscall
    move $t2, $v0               # t2 = value to insert

    li $t3, -1
    beq $t2, $t3, print_list    # if input = -1 → print list

    # Allocate new node (8 bytes)
    li $v0, 9
    li $a0, 8
    syscall
    move $t4, $v0               # t4 = new node address

    # Store data and initialize next = NULL
    sw $t2, 0($t4)
    sw $zero, 4($t4)

    # If head == NULL → new node is head
    lw $t5, 0($t0)
    beq $t5, $zero, first_node

    # Prompt for position
    li $v0, 4
    la $a0, prompt_pos
    syscall

    li $v0, 5
    syscall
    move $t6, $v0               # t6 = position index

    # Traverse to that index (0-based)
    move $t7, $t5               # t7 = current = head
    li $t8, 0                   # counter = 0
traverse:
    beq $t8, $t6, insert_after
    lw $t9, 4($t7)              # t9 = current->next
    beq $t9, $zero, insert_end  # reached end, insert at last
    move $t7, $t9               # current = current->next
    addi $t8, $t8, 1
    j traverse

insert_after:
    # newNode->next = current->next
    lw $t9, 4($t7)
    sw $t9, 4($t4)
    # current->next = newNode
    sw $t4, 4($t7)
    j update_count

insert_end:
    # current->next = newNode (append)
    sw $t4, 4($t7)
    j update_count

first_node:
    sw $t4, 0($t0)              # head = newNode

update_count:
    lw $t9, 0($t1)
    addi $t9, $t9, 1
    sw $t9, 0($t1)
    j insert_loop


# ------------------------------------
# Print the Linked List
# ------------------------------------
print_list:
    li $v0, 4
    la $a0, msg_list
    syscall

    lw $t5, 0($t0)              # t5 = head
print_loop:
    beq $t5, $zero, exit
    lw $a0, 0($t5)              # a0 = node->data
    li $v0, 1
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    lw $t5, 4($t5)              # t5 = node->next
    j print_loop

exit:
    li $v0, 10
    syscall
