.data
str1: .asciiz "Enter the number: "
str2: .asciiz "The factorial is: "

.text
main:

la $a0,str1
li $v0,4
syscall

li $v0,5
syscall

move $t0,$v0

move $t1, $t0
li $t2, 1

fac:
ble $t1, 1, exit_1
mul $t2, $t2, $t1
sub $t1, $t1, 1

j fac

exit_1:
la $a0, str1
li $v0, 4
syscall

move $a0, $t2
li $v0, 1
syscall

li $v0, 10
syscall

