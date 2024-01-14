######################################## LaPointeProg2.asm #########################################
#
####################################################################################################
#	Program Name:	Smallest of 3 Numbers     
#	Author:		Brandon LaPointe
#	Due Date:	September 21, 2021
#	Course/Section:	CSC 211-301W
#  Program Description:	Prompts the user to input 3 integers and calculates which was the smallest
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for three integers
#	Prompt user for first int
#	Prompt user for second int
#	Prompt user for third int
# Calculate the smallest of the three integers
#	Calculate the smaller of the first and second integers
#	Calculate the smallest of the smaller integer and the third integers
# Display the result
#
# Input Variables:   	
#   Int1 As Integer:	First user input to compare
#   Int2 As Integer:	Second user input to compare
#   Int3 As Integer:	Third user input to compare
#
# Output Variables:
#
#   Smallest As Integer:     The smallest integer ($t0)
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN SMALLEST OF THREE INTEGERS
# 1.  Print out prompt 1 to gather the first integer
#         Store first integer in $t1 for safe keeping
# 2.  Print out prompt 2 to gether the second integer
#	 Store the second integer in $t2 for safe keeping
# 3.  Print out prompt 3 to gather the third integer
#	 Store the third integer in $t3 for safe keeping
# 4.  Calculate the smallest of the three integers and store in $t0
#	 Calculate the smaller of the first two integers 
#	 	IF $t1 is less than $t2 then Branch to ELSE
#		IF $t2 > $t1 move $t1 -> $t0 for safe keeping
#	 	done with IF so jump over ELSE code to ENDIF label
#	 	ELSE $t2 is smallest so move $t2 -> $t0 for safe keeping
#	 	END IF
#	Calculate the smallest of the smaller and third integers
#		IF $t0 is less than $t3 then Branch to ELSE
#		IF t$0 > $t3 move t3 -> t0 for safe keeping  
#		done with IF so jump over ELSE code to ENDIF label
#		ELSE $t0 is smallest so leave $t0 alone
#		END IF
# 5.  Print output
#	 Print smallest integer ($t0)
# END SMALLEST OF THREE INTEGERS
#
####################################################################################################

        .text
        .globl main
main:


        #Print out prompt1
        la $a0,prompt1       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the first integer : "


        #Get the value of the first integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	#Move first int to $t1
	move $t1,$v0		# move integer from $v0 -> $t1 for safe keeping


        #Print out prompt2
        la $a0,prompt2       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the second integer : "


        #Get the value of the second integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	#Move second int to $t2
	move $t2,$v0		# move integer from $v0 -> $t2 for safe keeping


        #Print out prompt3
        la $a0,prompt3       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the third integer : "


        #Get the value of the third integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	#Move third int to $t3
	move $t3,$v0		# move integer from $v0 -> $t3 for safe keeping


        #Calculate the smallest of first and second int
	blt $t1, $t2, ELSE1      # IF $t1 < $t2 then Branch to ELSE
	move $t0,$t2             # IF $t1 > $t2 move $t2 -> $t0 for sfurther comparing  
	j ENDIF1                 # done with IF so jump over ELSE code to ENDIF label 
	ELSE1:  move $t0,$t1     # ELSE $t1 is smallest so move $t1 -> $t0 for further comparing


	ENDIF1:
	la $a0,endl              # load the new line character into $a0
	li $v0,4                 # load the call code number to display the string into $v0
	syscall                  # system call to print the new line character


	#Calculate the smallest of the smallest and third int
	blt $t0, $t3, ELSE2      # IF $t0 < $t3 then Branch to ELSE
	move $t0,$t3             # IF $t0 > $t3 move $t3 -> $t0 for safe keeping  
	j ENDIF2                 # done with IF so jump over ELSE code to ENDIF label 
	ELSE2:			 # ELSE $t0 is smallest, leave be


	ENDIF2:
	la $a0,endl              # load the new line character into $a0
	li $v0,4                 # load the call code number to display the string into $v0
	syscall                  # system call to print the new line character


        #Print out output
        la $a0,output       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "The smallest integer is : "


	#Print out the smallest integer
	move $a0,$t0		# display the smallest integer
	li $v0,1		# load call code to print an integer
	syscall			# system call to display the smallest integer stored in $t0


	#Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 09/21/2021 "


        #Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   ####Data Section####
   .data
   prompt1: 	.asciiz "Enter the first integer : "					#Prompt for first integer
   prompt2: 	.asciiz "Enter the second integer : "					#Prompt for second integer
   prompt3: 	.asciiz "Enter the third integer : "					#Prompt for third integer
   output: 	.asciiz "The smallest integer is : " 					#output message
   name:   	.asciiz "Brandon LaPointe 09/21/2021 "	 				#Output name and date
   endl:    	.asciiz "\n"								#New line character


############################################# Output1 ###############################################
#Enter the first integer : 3									    #
#Enter the second integer : 2									    #
#Enter the third integer : 1									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
############################################# Output2 ###############################################
#Enter the first integer : 3									    #
#Enter the second integer : 1									    #
#Enter the third integer : 2									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
############################################# Output3 ###############################################
#Enter the first integer : 1									    #
#Enter the second integer : 2									    #
#Enter the third integer : 3									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
############################################# Output4 ###############################################	
#Enter the first integer : 1									    #
#Enter the second integer : 3									    #
#Enter the third integer : 2									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
############################################# Output5 ###############################################
#Enter the first integer : 2									    #
#Enter the second integer : 1									    #
#Enter the third integer : 3									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
############################################# Output6 ###############################################
#Enter the first integer : 2									    #
#Enter the second integer : 3									    #
#Enter the third integer : 1									    #
#												    #
#												    #
#The smallest integer is : 1									    #
#Brandon LaPointe 09/21/2021 									    #
#												    #
#####################################################################################################