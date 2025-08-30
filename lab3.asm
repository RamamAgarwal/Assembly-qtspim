  .data
  buffer: .space 100
  .text
  main:
	  li $t0,2
	  li $t1,10
	  add $a0, $t0, $t1
	  
	  li $v0, 10
	  syscall