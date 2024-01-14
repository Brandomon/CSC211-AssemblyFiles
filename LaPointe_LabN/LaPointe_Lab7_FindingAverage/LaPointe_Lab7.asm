####################################################################################################
#
# LaPointe_Lab7.asm - Prompts user to enter 10 integers to calculate and print out the average
#
#	$t0 - beginning address of array
#       $t1 - size of the array
#	$t2 - holds each byte from the array
#	$t3 - loop counter
#	$t4 - total of the array elements
#	$t5 - average of the array elements
#
####################################################################################################
#
# Initial Algorithm:
#
# Initialize array, counter, total, and average
# Prompt user for 10 integers
# Store integers in array
#	Collect total
# Initialize array index and counter
# Load address of array
# Display the array
# Calculate and display average
#
# Input Variables:   	
#   input as int:	User input used to fill the array of 10 integers
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN FINDING AVERAGE
# 1.  Initialize
#	Initialize array
#	Initialize counter to zero
#	Initialize total and average to zero
# 2.   Fill the array
#	WHILE counter is less than the size of the array
#		Prompt user for integer
#		Get integer from user
#		Store integer in array
#		Increment array index by one word
#		Increment index counter
#		Add integer into total
#		Jump back to WHILE if the counter is less than the size of the array
# 3.  Display Array
#	Display title
#	Reinitialize loop values
#	Load address of array
#	PRINT (counter is less than the size of the array)
#	 	Print out the integers of the array
#	 	Print out comma
#		Increment array index and loop counter
#		Jump back to PRINT if the counter is less than the size of the array
# 4. Display Average and Name/DueDate/FavColor		
#	End PRINT Move to next line
#		Calculate the average
#		Display the average
#		Move to next line
#		Display name, due date, and favorite color
#		Move to next line
# END FINDING AVERAGE
#
####################################################################################################

        .text
        .globl main
main:

        	#Print out prompt
        	la $a0,prompt       	# load beginning address of string into $a0 register
        	li $v0,4             	# load call code to print a string into register $v0
        	syscall              	# system call to display "Enter 10 integers to find the average."


		#Move to next line
		la $a0,endl         	# display cr/lf
          	li $v0,4		# load call code to print a string (new line is a string)
          	syscall			# system call to move to next line

		
		#Initialize the array
		la $t0,array		# load the beginning address of the array into $t0
		li $t1,10		# initialize $t1 with the size of the array: 10 (0-9)


		#Initialize the counter to zero
		li $t3,0		# initialize $t3 - the loop counter - to start at zero


		#Initialize the total and average to zero
		li $t4,0		# initialize $t4 - the total - to zero
		li $t5,0		# initialize $t5 - the average - to zero


WHILE:      	#Get the integers from user
		la $a0,intPrompt	# prompts the user to enter an integer
		li $v0,4		# load the address of the string that contains the prompt
		syscall			# print the prompt


		#Store input from keyboard
		li $v0,5		# store the input from the keyboard into $v0
		syscall			# store the input


		#Store integer into array
		sw $v0,($t0)		# store the integer in $v0 into the array


		#Increment array pointer and loop counter
		add $t0,$t0,4		# increment the array pointer by one integer (one word)
		add $t3,$t3,1		# increment the loop counter


		#Add integer into total
		add $t4,$t4,$v0		# add integer into total


		blt $t3,$t1,WHILE	# if the counter is less than the size of the array then loop back to WHILE


		#Display title
		la $a0,title		# load the beginning address of title
		li $v0,4		# call code to display a string
		syscall			# display "Array: "


		#Reinitialize loop values
		li $t0,0		# initialize array index value back to zero
		li $t3,0		# initialize size counter back to zero


		#Load address of array
		la $t0,array		# load address of array back into $t0


PRINT:		#Print out the integers of the array
		lw $t2,($t0)		# load the word a[i] into temp ($t2)
		move $a0,$t2		# move a[i] to $a0 for display
		li $v0,1		# display a[i]
		syscall			# print the integer


		#Print out comma
		la $a0,comma		# load the comma character into $a0
		li $v0,4		# load instruction to print a string
		syscall			# print the comma


		#Increment array index and loop counter
		add $t0,$t0,4		# increment the array index
		add $t3,$t3,1		# increment the loop counter


		blt $t3,$t1,PRINT	# if the counter is less than the size of the array jump back to PRINT

		
ENDPRINT:	#Move to next line
	    	la $a0,endl         	# display cr/lf
          	li $v0,4		# load call code to print a string (new line is a string)
          	syscall			# system call to move to next line


		#Calculate the average
		div $t5,$t4,$t1		# total / array size -> $t5 (average)


		#Display the average
		la $a0,ans		# load beginning address of ans message into $a0 register
		li $v0,4		# load call code to print a string
		syscall			# display "The average is : "
		move $a0,$t5		# move average from $t5 -> $a0 for display
		li $v0,1		# load call code to print an integer
		syscall			# display the average


		#Move to next line
		la $a0,endl         	# display cr/lf
          	li $v0,4		# load call code to print a string (new line is a string)
          	syscall			# system call to move to next line


		#Display name, due date, and favorite color
		la $a0, name		# load beginning address of display message into $a0 register
		li $v0,4		# load call code to print a string
		syscall			# display "Brandon LaPointe ~ Due : 10/11/2021 ~ Favorite color : Green"


        	#Move to next line       
        	la $a0,endl		# display cr/lf
        	li $v0,4		# load call code to print a string (new line is a string)
        	syscall			# system call to move to next line


	        #End the program
        	li $v0,10            	# load call code to End Program
        	syscall              	# system call to end program

       
   ####Data Section####
   .data
   array: 	.space 40					# Array of 10 integers (words)
   prompt: 	.asciiz "Enter 10 integers to find the average."# Prompt for user to enter 10 integers
   intPrompt:	.asciiz "Enter an integer : "			# Prompt for user to enter an integer
   title:	.asciiz "Array: "				# Title output for array
   comma:	.asciiz ", "					# Comma character for output
   ans:    	.asciiz "The average is : "			# Output message for the average
   name:   	.asciiz "Brandon LaPointe ~ Due : 10/11/2021 ~ Favorite color : Green" 	
								# Output name, due date, and favorite color
   endl:    	.asciiz "\n"					# New line character

############################################## Output ###################################################
#Enter 10 integers to find the average.									#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 13											#
#Enter an integer : 14											#
#Enter an integer : 413											#
#Array: 13, 13, 13, 13, 13, 13, 13, 13, 14, 413, 							#
#The average is : 53											#
#Brandon LaPointe ~ Due : 10/11/2021 ~ Favorite color : Green						#
#													#
#########################################################################################################