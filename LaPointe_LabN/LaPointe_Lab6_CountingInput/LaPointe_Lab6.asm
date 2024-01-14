####################################################################################################
#
# LaPointe_Lab6.asm - Prompts user to enter a string to calculate and print out the length of characters
#
#	$t0 - holds each byte from string in turn
#       $t1 - contains count of characters
#	$t2 - holds string input by user
#
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for a string
# Store string
# Initialize counter to 0
# Load address of string
# Calculate length of string
#	IF byte equals '\0' jump to display result
#	Get byte from string
#	Increment counter
#	Move to next character
#	Jump back to get next byte
# Display the result
#
# Input Variables:   	
#   input as string:	User input string used to find length
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN EVEN OR ODD
# 1.  Print out prompt1 to gather the string
#	Get the string from User
#       Initialize counter to zero
#	Load address of input string
# 2.  Calculate length of string input
#	 WHILE there are more characters in string extract a byte from the string and store in $t0
#	 	Branch to EndWhile if the byte extracted is the end of the string
#	 	Increment the counter (count the byte extracted)
#		Move to next character in the string
#		Jump back to WHILE to loop again
#	End While and display the length
#		remove enter key input from length
#		load beginning address of ans output into $a0 register
#		Display length
#		Move to next line
#		Display name and date
#		Move to next line
# END EVEN OR ODD
#
####################################################################################################

        .text
        .globl main
main:

        	#Print out prompt
        	la $a0,prompt       	# load beginning address of string into $a0 register
        	li $v0,4             	# load call code to print a string into register $v0
        	syscall              	# system call to display "Enter a string : "


        	#Get the string from User
		la $a0,input		# get address of string variable
		li $a1,80		# set string length
        	li $v0,8             	# load call code to read a string from keyboard
		syscall			# read string


		#Initialize the counter to 0
		li $t1,0		# $t1 holds the count


		#Load address of input string
		la $t2,input


#WHILE there are more characters in string extract a byte from the string and store in $t0
WHILE:		lb $t0,($t2)        	# get a byte from the string

		#Branch to EndWhile if the byte extracted is the end of the string
        	beqz $t0,ENDWHILE   	# zero means end of string

		#Increment the counter (count the byte extracted)
        	add $t1,$t1,1       	# increment count

		#Move to next character in the string
        	add $t2,1           	# move pointer one character

		#Jump back to WHILE to loop again
       		j WHILE             	# go around the loop again

		
#End While and display the length
ENDWHILE:	sub $t1, 1		# remove enter key input from length

		la $a0,ans          	# load beginning address of ans output into $a0 register
          	li $v0,4	    	# load call code to print a string 
          	syscall		    	# system call to display "The length is : "

 
		#Display length
          	move $a0,$t1        	# load beginning address of string length into $a0 register
          	li $v0,1		# load call code to print an integer
          	syscall			# system call to display length


		#Move to next line
          	la $a0,endl         	# display cr/lf
          	li $v0,4		# load call code to print a string (new line is a string)
          	syscall			# system call to move to next line


		#Display name and date
		la $a0, name		# load beginning address of display message into $a0 register
		li $v0,4		# load call code to print a string
		syscall			# system call to display "Brandon LaPointe 10/03/2021 "


        	#Move to next line       
        	la $a0,endl		# display cr/lf
        	li $v0,4		# load call code to print a string (new line is a string)
        	syscall			# system call to move to next line


	        #End the program
        	li $v0,10            	# load call code to End Program
        	syscall              	# system call to end program

       
   ####Data Section####
   .data
   input: 	.space 81
   prompt: 	.asciiz "Enter a string : "			#Prompt for user to enter a string
   ans:    	.asciiz "The length is : "			#Output message for the length of the string
   name:   	.asciiz "Brandon LaPointe 10/03/2021 "	 	#Output name and date
   endl:    	.asciiz "\n"					#New line character

############################################## Output ###################################################
#Enter a string : My god, it finally works								#
#The length is : 24											#
#Brandon LaPointe 10/03/2021 										#
#									     				#
#########################################################################################################