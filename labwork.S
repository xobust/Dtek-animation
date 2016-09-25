.global delay
.global time2string 
.text
   # labwork.S
  # Written 2015 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1 2015-2016.
  # The macros PUSH and POP are in the public domain.

.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm

  # You can add your own code here
  #

hexasc:
	andi $a0, $a0, 0xf
	slti $t0, $a0, 10
	beq  $t0, $0, char
	nop			#Branch delay slot
	
	addi $v0, $a0, 0x30	#Number offset
	jr $ra
	nop			#Branch delay slot
char: 
	addi $v0, $a0, 0x37 	#Alpha offset - 10
	jr $ra
	nop
	
delay: 
	addi $t2, $0, 15000
	
	slti $t0, $a0, 1
	bne  $t0, $0, notdelay
	nop
	addi $a0, $a0, -1
	add  $t1, $0, $0
	
	loop:
		slt $t3, $t1, $t2
		beq $t3, $0, delay
        addi $t1, $t1, 1
		j loop
		nop
notdelay:
	jr $ra
	nop
	
time2string:
	PUSH $ra		#Save variables on the stack
	PUSH $s0
	PUSH $s1
	add  $s0, $a0, $0	#Store adress
	andi $s1, $a1, 0xffff	#Store time data
	
	and $t0, $t0, $0
	sb  $t0, 5 ($s0)
	
	andi $a0, $s1, 0xf
	srl  $s1, $s1, 4
	jal  hexasc
	nop
	sb $v0, 4 ($s0)
	
	andi $a0, $s1, 0xf
	srl  $s1, $s1, 4
	jal  hexasc
	nop
	sb $v0, 3 ($s0)
	
	addi $t0, $0, 0x3a
	sb $t0, 2($s0)
	
	andi $a0, $s1, 0xf
	srl  $s1, $s1, 4
	jal  hexasc
	nop
	sb $v0, 1 ($s0)
	
	andi $a0, $s1, 0xf
	srl  $s1, $s1, 4
	jal  hexasc
	nop
	sb $v0, 0 ($s0)
	

	POP $s0 
	POP $s1 
	POP $ra 
	jr $ra
	nop		#Branch delay slot
	
