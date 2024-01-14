####################################################################################################
#
# LaPointe_Lab8.asm - 	Prompts user to enter an integer of how many numbers to collect for an array 
#			of integers before prompting the user for each element of the array of the
#			given size. The program then finds the lowest and highest within the array.
#
#	$t0 - byte counter
#       $t1 - counter
#	$t2 - min
#	$t3 - max
#	$t4 - array element
#	$t5 - address of array element
#	$t6 - temp
#	$t7 - size of array
#	$t8 - size of array - 1
#
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for size of array
# Initialize array, counters, min, and max
# Prompt user for integers
# Store integers in array
# Initialize array index and counter
# Load address of array
# Loop to find min and max
# Initialize array index and counter
# Load address of the array
# Display the array
#
# Input Variables:  
#	$t7 as int - Size of array input by user 	
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
# BEGIN FINDING AVERAGE
# 1.  Prompt user for size of array
#	Get user input of numbers to be entered
#	Calculate size of array - 1 and store in $t8
# 2. Load array and initialize counter
#	Load address of the array
#	Initialize counter to zero
# 3. Fill the array
#	WHILE counter is less than the size of the array
#		Prompt user for integer
#		Get integer from user
#		Store integer in array
#		Increment array index by one word
#		Increment index counter
#		Jump back to WHILE if the counter is less than the size of the array
# 4. Display Array
#	Display title
#	Reinitialize loop values
#	Load address of array
#	PRINT (counter is less than the size of the array)
#	 	Print out the integers of the array
#	 	Print comma if counter is not at end
#		Increment array index and loop counter
#		Jump back to PRINT if the counter is less than the size of the array
# 5. Calculate the min and max of the array
#	Load address of the array
#	Initialize count to zero
#	Initialize min and max to first element of the array
#	Move pointer to compare next array element
#	Loop for min and max
# 6. Display Min/Max/Name/DueDate/FavFood
#	Display min message
#	Display the minimum number
#	Display max message
#	Display the maximum number
#	Move to next line
#	Display name, due date, and favorite color
# END FINDING AVERAGE
#
####################################################################################################

        .text
        .globl main
main:

	#Print out prompt
	la $a0,prompt		# Load address of prompt
	li $v0,4		# Load call code to display a string
	syscall			# Display "How many numbers will be entered? *Must be 15 or less* : "


	#Get user input of numbers to be entered
	li $v0,5		# Load call code to read an integer from the keyboard
	syscall			# Read integer and store in $v0
	move $t7,$v0		# Move integer from $v0 to $t7 for safe keeping


	#Calculate size of array - 1 and store in $t8
	sub $t8, $t7, 1		# size of array - 1 -> $t8

	
	#Load address of the array
        la $t0,array        	# t0 = address of array

	
	#Initialize count to zero
        li $t1,0        	# t1 = count, exit loop when it goes to array size


WHILE:  #Prompt user for integer
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
	add $t1,$t1,1		# increment the loop counter


	blt $t1,$t7,WHILE	# if the counter is less than the size of the array then loop back to WHILE


END:	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display title
	la $a0,title		# load the beginning address of title
	li $v0,4		# call code to display a string
	syscall			# display "Array: "


	#Reinitialize loop values
	li $t0,0		# initialize array index value back to zero
	li $t1,0		# initialize size counter back to zero


	#Load address of array
	la $t0,array		# load address of array back into $t0


PRINT:	#Print out the integers of the array
	lw $t6,($t0)		# load the word a[i] into temp ($t6)
	move $a0,$t6		# move a[i] to $a0 for display
	li $v0,1		# display a[i]
	syscall			# print the integer


	#Print comma if counter is not at end
	beq $t1, $t8,skip	#if counter is last of array, skip comma


	#Print out comma
	la $a0,comma		# load the comma character into $a0
	li $v0,4		# load instruction to print a string
	syscall			# print the comma


skip:	#Increment array index and loop counter
	add $t0,$t0,4		# increment the array index
	add $t1,$t1,1		# increment the loop counter


	blt $t1,$t7,PRINT	# if the counter is less than the size of the array jump back to PRINT

		
ENDPRINT:	
	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line	


	#Calculate the min and max of the array
	#Load address of the array
        la $t0,array        	# t0 = load beginning address of array into $t0

	
	#Initialize count to zero
        li $t1,0        	# t1 = count, exit loop when it goes to array size


	#Initialize min and max to first element of the array
        lw $t2,($t0)        	# t2 = min = a[0] (initialization)
        lw $t3,($t0)        	# t3 = max = a[0] (initialization)


	#Move pointer to compare next array element
        add $t0,$t0,4       	# move byte pointer ahead to next array element a[1]
        add $t1,$t1,1      	# increment counter to keep in step with array


loop:   lw $t4,($t0)       	# t4 = next element in array
        bge $t4,$t2,notMin  	# if array element is >= min goto notMin
        move $t2,$t4        	# min = a[i]
        j notMax


notMin: ble $t4,$t3,notMax 	# if array element is <= max goto notMax
        move $t3,$t4        	# max = a[i]


notMax: add $t1,$t1,1      	# t1 -- -> counter --
        add $t0,$t0,4       	# increment counter to point to next word
        blt $t1,$t7,loop	# loop back if counter is less than array size


	#Display min message
        la $a0,min           	# load address of min message into $a0 for display
        li $v0,4            	# call code to display a string
        syscall             	# display "The minimum number is : "

      
	#Display the minimum number 
        move $a0,$t2        	# Display the minimum number 
        li $v0,1		# call code to display an integer
        syscall			# display min number


	#Display max message
        la $a0,max           	# load address of max message into $a0 for display
        li $v0,4            	# call code to display a string
        syscall             	# display "The maximum number is : "


	#Display the maximum number
        move $a0,$t3        	# move $t3 to $a0 for display
        li $v0,1		# load call to display an integer
        syscall			# display max number


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display name, due date, and favorite color
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# display "Brandon LaPointe ~ Due : 10/11/2021 ~ Favorite food : Ice Cream"


	#End the program
       	li $v0,10            	# load call code to End Program
        syscall              	# system call to end program
        
.data
array:		.word 15								# Array of 15 integers (words)
prompt:		.asciiz "How many numbers will be entered? *Must be 15 or less* : "	# Prompt for user to enter array size
intPrompt:	.asciiz "Enter an integer : "						# Prompt for user to enter an integer
min:     	.asciiz "\nThe minimum number is : "					# Output for displaying min number
max:     	.asciiz "\nThe maximum number is : "					# Output for displaying max number
title:		.asciiz "Array: "							# Title output for array
comma:		.asciiz ", "								# Comma character for output
endl:    	.asciiz "\n"								# New line character
name:   	.asciiz "Brandon LaPointe ~ Due : 10/11/2021 ~ Favorite food : Ice Cream" # Output name, due date, and favorite food