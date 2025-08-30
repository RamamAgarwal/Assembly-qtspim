.data
  buffer: .space 100
  .text
  main:
	  li $t0,2
	  li $t1,10
	  div $a0, $t1, $t0
	  
	  li $v0,1
	  syscall
	  
	  li $v0, 10
	  syscall