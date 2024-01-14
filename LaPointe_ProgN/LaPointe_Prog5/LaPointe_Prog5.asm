####################################################################################################
#
# LaPointe_Prog5.asm - Count the occurances of characters and vowels within a string input by the user 	                                #
# 			Indexed addressing used to access array elements
#
# t0 = holds each byte from string in turn
# t1 = index into array
# t2 = count of occurances                              
# t3 = character to be searched for
# t4 = holds the string input by user
# t5 = total count of letters in string
#
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for string
# Get string from user
# Calculate total characters
# Count occurances of 'A'
#	Add into total
# Count occurances of 'E'
#	Add into total
# Count occurances of 'I'
#	Add into total
# Count occurances of 'O'
#	Add into total
# Count occurances of 'U'
#	Add into total
# Display total character count
# Display vowel count
# Display name and due date
# Display OCC Advisor
# End program
#
# Input Variables:  	
#   	($t0) as int - User input used to fill the array of integers
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN COUNTING REVISITED
# 1.  Prompt user string
# 2.  Get string from user
# 3.  Initialize vowel counter to zero
# 4.  Calculate total characters in string
#	Initialize array index to 0
#	Initialize total counter to 0
#total: Fetch next character
#	IF its a null character, jump to totEnd
#	ELSE IF character - add 1 to total counter
#	Increment array index
#	jump back to total
#totEnd:remove count of enter key
# 5.  Count occurances of 'A'
#	Initialize array index to 0
#	Load byte of character to be searched for
#loopA:	Fetch next character
#	IF its a null character, exit loop
#	IF != search character goto conA
#	IF == search, add 1 to vowel counter
#conA:	Add one to array index
#	Jump back to loopA
# 6.  Count occurances of 'E'
#	Initialize array index to 0
#	Load byte of character to be searched for
#loopE:	Fetch next character
#	IF its a null character, exit loop
#	IF != search character goto conE
#	IF == search, add 1 to vowel counter
#conE:	Add one to array index
#	Jump back to loopE
# 7.  Count occurances of 'I'
#	Initialize array index to 0
#	Load byte of character to be searched for
#loopI:	Fetch next character
#	IF its a null character, exit loop
#	IF != search character goto conI
#	IF == search, add 1 to vowel counter
#conI:	Add one to array index
#	Jump back to loopI
# 8.  Count occurances of 'O'
#	Initialize array index to 0
#	Load byte of character to be searched for
#loopO:	Fetch next character
#	IF its a null character, exit loop
#	IF != search character goto conO
#	IF == search, add 1 to vowel counter
#conO:	Add one to array index
#	Jump back to loopO
# 9.  Count occurances of 'U'
#	Initialize array index to 0
#	Load byte of character to be searched for
#loopU:	Fetch next character
#	IF its a null character, exit loop
#	IF != search character goto conU
#	IF == search, add 1 to vowel counter
#conU:	Add one to array index
#	Jump back to loopU
# 10.  Display the information
#	Display total character title
#	Display total character count
#	Move to next line
#	Display vowel count title
#	Display vowel count
#	Move to next line
#	Display name and due date
#	Move to next line
#	Display OCC advisor
# END COUNTING REVISITED
#
####################################################################################################
        .text
        .globl main
main:

	#Prompt user for string
	la $a0,prompt		# load address of prompt
	li $v0,4		# call code to print a string into register $v0
	syscall			# display "Enter a string : "


	#Get string from user
	la $a0,str		# get address of string variable
	li $a1,80		# set string length
	li $v0,8		# call code to read string from keyboard
	syscall			# read string


	#Get total number of characters are in string
	li $t1,0		# initialize array index to 0
	li $t5,0		# initialize total counter to 0

total:	lb $t0,str($t1)		# fetch next character
        beqz $t0,totEnd    	# if its a null character, exit loop
        add $t5,$t5,1        	# else if character - add 1 to total counter
	add $t1,$t1,1		# increment array index
	j total			# jump back to total


totEnd: sub $t5,$t5,1		# remove count of enter key	

	#Initialize vowel counter to zero
	li $t2,0             	# intialize counter to 0


	#Count occurances of 'A'
        li $t1,0             	# initialize array index to 0
        lb $t3,a             	# t3 = character to be searched for

loopA:  lb $t0,str($t1)      	# fetch next character
        beqz $t0,strEndA     	# if its a null character, exit loop
        bne $t0,$t3,conA     	# if != search character goto conA
        add $t2,$t2,1        	# if yes - add 1 to counter

conA:   add $t1,$t1,1        	# add one to array index
        j loopA              	# goto loopA

	
strEndA:#Count occurances of 'E'
        li $t1,0             	# initialize array index to 0
        lb $t3,e             	# t3 = character to be searched for

loopE:  lb $t0,str($t1)      	# fetch next character
        beqz $t0,strEndE     	# if its a null character, exit loop
        bne $t0,$t3,conE     	# if != search character goto conE
        add $t2,$t2,1        	# if yes - add 1 to counter

conE:   add $t1,$t1,1        	# add one to array index
        j loopE              	# goto loopE


strEndE:#Count occurances of 'I'
        li $t1,0             	# initialize array index to 0
        lb $t3,i             	# t3 = character to be searched for

loopI:  lb $t0,str($t1)      	# fetch next character
        beqz $t0,strEndI     	# if it's a null character, exit loop
        bne $t0,$t3,conI     	# if != search character goto conI
        add $t2,$t2,1        	# if yes - add 1 to counter

conI:   add $t1,$t1,1        	# add one to array index
        j loopI              	# goto loopI


strEndI:#Count occurances of 'O'
        li $t1,0             	# initialize array index to 0
        lb $t3,o             	# t3 = character to be searched for

loopO:  lb $t0,str($t1)      	# fetch next character
        beqz $t0,strEndO     	# if its a null character, exit loop
        bne $t0,$t3,conO     	# if != search character goto conO
        add $t2,$t2,1        	# if yes - add 1 to counter

conO:   add $t1,$t1,1        	# add one to array index
        j loopO              	# goto loopO


strEndO:#Count occurances of 'U'
        li $t1,0             	# initialize array index to 0
        lb $t3,u             	# t3 = character to be searched for

loopU:  lb $t0,str($t1)      	# fetch next character
        beqz $t0,strEndU     	# if its a null character, exit loop
        bne $t0,$t3,conU     	# if != search character goto conU
        add $t2,$t2,1        	# if yes - add 1 to counter

conU:   add $t1,$t1,1        	# add one to array index
        j loopU              	# goto loopU


strEndU:#Display "Total characters : "
	la $a0,tot		# display total title
	li $v0,4		# call code to display a string
	syscall			# display "Total characters : "


	#Display total count
	move $a0,$t5		# move total count to $a0 for display
	li $v0,1		# call code to display an integer
	syscall			# display total count


	#Display new Line
        la $a0,endl          	# display crlf
        li $v0,4		# call code to display a string
        syscall			# display new line character


	#Display "Vowel count : "
	la $a0,ans           	# display ans title
        li $v0,4		# call code to display a string
        syscall			# display "Vowel count : "
	

	#Display vowel count
        move $a0,$t2         	# move vowel count to $a0 for display
        li $v0,1		# call code to display an integer
        syscall			# display vowel count


	#Display new Line
        la $a0,endl          	# display crlf
        li $v0,4		# call code to display a string
        syscall			# display new line character


	#Display "Brandon LaPointe --- Due Date : 10/18/2021"
        la $a0,name          	# display name and due date
        li $v0,4		# call code to display a string
        syscall			# display "Brandon LaPointe --- Due Date : 10/18/2021"


	#Display new line
        la $a0,endl          	# display crlf
        li $v0,4		# call code to display a string
        syscall			# display new line character


	#Display OCC Advisor
        la $a0,advisor       	# display OCC advisor
        li $v0,4		# call code to display a string
        syscall			# display "OCC Advisor : Sheila S. Sicilia"


	#Display new line
        la $a0,endl          	# display crlf
        li $v0,4		# call code to display a string
        syscall			# display new line character


	#End program
        li $v0,10            	# eop
        syscall			# end program

  ####Data Section####
  .data
  prompt:	.asciiz "Enter a string : "				#Prompt for user to enter a string
  a: 		.asciiz "a"						#'A' char for search
  e: 		.asciiz "e"						#'E' char for search
  i: 		.asciiz "i"						#'I' char for search
  o: 		.asciiz "o"						#'O' char for search
  u: 		.asciiz "u"						#'U' char for search
  endl: 	.asciiz "\n"						#New line character
  tot:		.asciiz "Total characters : "				#Title for total characters
  ans: 		.asciiz "Vowel count : "				#Title for count of vowels
  name:		.asciiz "Brandon LaPointe --- Due Date : 10/18/2021"	#Output of name and due date
  advisor:	.asciiz "OCC Advisor : Sheila S. Sicilia"		#Output for OCC advisor
  str: 		.space 81  						#Space reserved for string input