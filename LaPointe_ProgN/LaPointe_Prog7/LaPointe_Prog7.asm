####################################################################################################
#
# LaPointe_Prog7.asm -  Loads the address 0x536F6E79 ("Sony") into register $t1 and prints out the
#			ASCII value of the 8 least most bits then loops 3 times, rotating the bits
#			to the right and extracting the following 3 characters.
#
#	$t0 - loop cycles
#	$t1 - address loaded in (0x536F6E79)
#
####################################################################################################
#
# Initial Algorithm:
#
# 	Load address 0x536F6E79 into $t1 ("Sony")
#	Rotate left 8 bits
# 	Mask and extract the least most 8 bits and print the ASCII value
# 	Initialize $t0 with loop cycles
# loop	Rotate 8 bits to the left, mask, and print ASCII value of least 8 bits
#	Decrement cycles by one and repeat if cycles aren't equal to zero
#	New line
#	Display name and due date
#	New line
#	Display right or left handed when writing
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
	#Load hex word into $t1
	li $t1, 0x536F6E79	# load hex word into $t1


	#Rotate left 8 bits
	rol $t1,$t1,8   	# rotate 8 bits to the left


	#Mask and extract the least most 8 bits and print the ASCII value
	andi $a0,$t1,0xff	# and $t1 with mask to extract the least most 8 bits on the right, place in $a0 register
	li $v0,11		# system call code to display ASCII value
	syscall			# print the ASCII value


	#Initialize $t0 with loop cycles
        li $t0,3        	# loop 3 times to get remaining bytes


loop:   #Rotate 8 bits to the left, mask, and print ASCII value of least 8 bits
	rol $t1,$t1,8   	# rotate 8 bits to the left
        andi $a0,$t1,0xff 	# mask one digit in $t1 and place results in $a0
	li $v0,11		# system call code to display ASCII value
	syscall			# print the ASCII value


	#Decrement cycles by one and repeat if cycles aren't equal to zero
        sub $t0,$t0,1  		# decrement $t0 by one
        bnez $t0,loop   	# repeat loop as long as $t0 != 0


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character

	
	#Display name and due date
	la $a0,name		# display name and due date
	li $v0,4		# system call code to display a string
	syscall			# print "Brandon LaPointe - Due Date : 11-08-2021"


	#New line
	la $a0,endl     	# display cr/lf
        li $v0,4		# system call code to display a string
        syscall			# print a new line character

	
	#Display right or left handed when writing
	la $a0,write		# display if right or left handed when writing
	li $v0,4		# system call code to display a string
	syscall			# print "I write with my right hand."

	
	#End Program
        li $v0,10       	# eop
        syscall

        .data

endl:   .asciiz "\n"								#New line character
name: 	.asciiz "Brandon LaPointe - Due Date : 11-08-2021"			#Output of first name and due date
write:  .asciiz "I write with my right hand."					#Output of right or left handed when writing