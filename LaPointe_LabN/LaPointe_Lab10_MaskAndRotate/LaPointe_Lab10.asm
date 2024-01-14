####################################################################################################
#
# LaPointe_Lab10.asm - Loads the address 0x44434241 into register $t2 and prints out the ASCII value
#			along with the following 3 bytes.
#
#	$t0 - loop cycles
#	$t2 - address loaded in (0x44434241)
#
####################################################################################################
#
# Initial Algorithm:
#
# 	Load address 0x44434241 into $t2
# 	Mask and extract the least most 8 bits and print the ASCII value
# 	New line
# 	Initialize $t0 with loop cycles
# loop	Rotate 8 bits to the right, mask, and print ASCII value of least 8 bits
# 	New line
#	Decrement cycles by one and jump to loop if cycles aren't equal to zero
#	New line
#	Display name and due date
#	New line
#	Display choise of name
#	End Program
#
# Input Variables: NONE
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################

       .text
       .globl main

main:
	#Load address 0x44434241 into $t2
	li $t2, 0x44434241	# load address into $t2


	#Mask and extract the least most 8 bits and print the ASCII value
	andi $a0,$t2,0xff	# and $t2 with mask to extract the least most 8 bits on the right, place in $a0 register
	li $v0,11		# system call code to display ASCII value
	syscall			# print the ASCII value


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character


	#Initialize $t0 with loop cycles
        li $t0,3        	# loop 3 times to get remaining bytes


loop:   #Rotate 8 bits to the right, mask, and print ASCII value of least 8 bits
	ror $t2,$t2,8   	# rotate 8 bits to the right
        andi $a0,$t2,0xff 	# mask one digit in t2 and place results in $a0
	li $v0,11		# system call code to display ASCII value
	syscall			# print the ASCII value


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character


	#Decrement cycles by one and jump to loop if cycles aren't equal to zero
        sub $t0,$t0,1  		# decrement $t0 by one
        bnez $t0,loop   	# repeat loop as long as $t0 != 0


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character

	
	#Display name and due date
	la $a0,name		# display name and due date
	li $v0,4		# system call code to display a string
	syscall			# print name and due date


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character

	
	#Display choise of first name
	la $a0,first		# display choise of first name if possible
	li $v0,4		# system call code to display a string
	syscall			# print choise of first name if possible

	
	#End Program
        li $v0,10       	# eop
        syscall

        .data

endl:   .asciiz "\n"								#New line character
name: 	.asciiz "Brandon LaPointe - Due Date : 11-08-2021"			#Output of first name and due date
first:  .asciiz "If I could choose my own first name, it would be Felix."	#Output of choise of first name