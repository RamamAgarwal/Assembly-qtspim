.data
  buffer: .space 100
  .text
  main:
	  li $t0,17
	  li $t1,7
	  div $a0, $t0, $t1 #LO stores quotient whereas HI remainder
	  
	  li $v0,1
	  syscall
	  
	  li $v0, 10
	  syscall