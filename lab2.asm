.data
buffer: .space 100
.text
main:
  la $a0, buffer # pointing to the buffer
  li $a1, 100 # storing the max length of the buffer(how many bytes)
  
  li $v0, 8 # reading the string
  syscall
  
  li $v0, 4 
  syscall

  li $v0, 10
  syscall