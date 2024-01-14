######################################## LaPointeProg3.asm #########################################
#
####################################################################################################
#	Program Name:	Even Or Odd    
#	Author:		Brandon LaPointe
#	Due Date:	September 22, 2021
#	Course/Section:	CSC 211-301W
#  Program Description:	Prompts the user to input an integer and calculates if it is even or odd
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for an integer
# Calculate if int is even or odd
#	Divide integer by 2
#	Store hi and lo registers
#	Comepare hi register to see if equal to 0
# Display the result
#
# Input Variables:   	
#   Int1 As Integer:	User input to calculate if odd or even
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
# 1.  Print out prompt1 to gather the integer
#         Store first integer in $t1 for safe keeping
# 2.  Calculate if integer is even or odd
#	 Initialize divisor of 2 as int to $t2
#	 Divide integer by 2 (Store hi)
#	 	Move quantity in Hi register to $t0
#	 IF $t0 = 0 then Branch to ELSE
#	 IF $t0 != 0 display odd output message
#	 done with IF so jump over ELSE code to ENDIF label
#	 ELSE $t1 is even so display even output message
#	 END IF
# END EVEN OR ODD
#
####################################################################################################

        .text
        .globl main
main:


        #Print out prompt1
        la $a0,prompt1       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter an integer : "


        #Get the value of the first integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	#Move first int to $t1
	move $t1,$v0		# move integer from $v0 -> $t1 for safe keeping


        #Calculate if integer is even or odd
	#Initialize integer value for calculation
	li $t2, 2


	#Divide integer by 2 and store hi register
	div $t1,$t2		 # Divide user input by 2 and store Hi
	mfhi $t0      		 # move quantity in special register Hi to $t0:   $t0 = Hi

	
	beqz $t0, ELSE1      	 # IF $t0 = 0 then Branch to ELSE
	la $a0,odd	         # IF $t0 != 0 display odd output message 
	li $v0,4             	 # load call code to print a string into register $v0 
	syscall			 # system call to print the string
	j ENDIF1                 # done with IF so jump over ELSE code to ENDIF label 
	ELSE1:  la $a0,even      # ELSE $t1 is even so display even output message
	li $v0,4		 # load call code to print a string into register $v0
	syscall			 #system call to print the string


	ENDIF1:
	la $a0,endl              # load the new line character into $a0
	li $v0,4                 # load the call code number to display the string into $v0
	syscall                  # system call to print the new line character


	#Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 09/22/2021 "


        #Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   ####Data Section####
   .data
   prompt1: 	.asciiz "Enter an integer : "						#Prompt for integer to determine if even or odd
   even: 	.asciiz "The integer entered is an even number"				#Display message for an even number
   odd: 	.asciiz "The integer entered is an odd number"				#Display message for an odd number
   name:   	.asciiz "Brandon LaPointe 09/22/2021 "	 				#Output name and date
   endl:    	.asciiz "\n"								#New line character

############################################## Output1 ###############################################
#Enter an integer : 173										     #
#The integer entered is an odd number								     #
#												     #
#Brandon LaPointe 09/22/2021 									     #
#												     #
############################################## Output2 ###############################################
#Enter an integer : 200										     #
#The integer entered is an even number								     #
#												     #
#Brandon LaPointe 09/22/2021 									     #
#												     #
######################################################################################################
