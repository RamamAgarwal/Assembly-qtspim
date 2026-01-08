.data
str: .asciiz "Hello World"
.text
main:
  la $a0, str # loading accumulator
  li $v0, 4 # print string system call
  syscall

  li $v0, 10  # exiting the program
  syscall