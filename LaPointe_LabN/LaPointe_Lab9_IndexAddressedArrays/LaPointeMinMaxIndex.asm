####################################################################################################
#
# LaPointeMinMaxIndex.asm - Prompts user to enter 10 integers to be stored within an array before
#			    calculating and displaying the lowest and highest within the array.
#
#	$t0 - array index
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
# Prompt user for 10 integers
# Collect and store integers in array
# Initialize array index and counter
# Print array using index
# Initialize array index and counter
# Loop to find min and max
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
# BEGIN FINDING AVERAGE
# 1.  Prompt user for 10 integers
#	Move to next line
#	Initialize counter to zero
#	Initialize index to zero
#	Initialize size of array
#	Initialize size of array - 1
# 2.  Collect and store integers in array
# while Prompt user for integer
#	Store input from keyboard
#	Store integer into array
#	Increment array index and loop counter
#	WHILE counter is less than size of array jump back to while
# wend	Move to next line
#	Display title
#	Reinitialize loop values
# print Print out the integers of the array
#	Print comma if counter is not equal to array size - 1
# skip	Increment array index and loop counter
#	WHILE counter is less than size of the array jump back to print
# endp	Move to next line
#	Calculate min and max of array
#	Reinitialize loop values
#	Initialize min and max to first array element
#	Move pointer to compare next array element
# loop	Compare integers of the array
#		IF array element is >= min goto notMin
# notMin	IF array element is <= max goto notMax
# notMax	Increment counter and index
#		WHILE counter is less than array size jump back to loop
#	Display min message
#	Display min number
#	Display max message
#	Display max number
#	Move to next line
#	Display name and due date
#	Move to next line
#	Display OCC advisor
# END FINDING AVERAGE
#
####################################################################################################
        .text
        .globl main
main:
	#Print out prompt
	la $a0,prompt		# Load address of prompt
	li $v0,4		# Load call code to display a string
	syscall			# Display "Please enter 10 integer values : "


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Initialize counter to zero
	li $t0, 0		# init loop counter to 0


	#Initialize index to zero
	li $t1, 0		# init index to 0
	

	#Initialize size of array
	li $t7, 10		# size of array -> $t7


	#Initialize size of array - 1
	li $t8, 9		# size of array - 1 -> $t8


while:	#Prompt user for integer
	la $a0,intPrompt	# prompt for integer
	li $v0,4		# call code to display a string
	syscall			# display "Enter an integer : "


	#Store input from keyboard
	li $v0,5		# enter input -> $v0
	syscall			# read an integer

	
	#Store integer into array
	move $t4,$v0		# store word int to a[i]
	sw $t4,array($t1)	# store word int into array

	
	#Increment array index and loop counter
	add $t1,$t1,4		# move index ahead to next array element
	add $t0,$t0,1		# increment counter

 
	#WHILE counter is less than size of array jump back to while
	blt $t0,10,while	# branch to while if counter < size of array

	
wend:	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display title
	la $a0,title		# display "Array : "
	li $v0,4		# call code to print a string
	syscall			# display "Array : "


	#Reinitialize loop values
	li $t0,0		# initialize counter back to zero
	li $t1,0		# initialize array index back to zero


print:	#Print out the integers of the array
	lw $t6,array($t1)	# load the word a[i] into temp ($t6)
	move $a0,$t6		# move a[i] to $a0 for display
	li $v0,1		# display a[i]
	syscall			# print the integer

	
	#Print comma if counter is not at end
	beq $t0,$t8,skip	#if counter is last of array, skip comma


	#Print out comma
	la $a0,comma		# load the comma character into $a0
	li $v0,4		# load instruction to print a string
	syscall			# print the comma


skip:	#Increment array index and loop counter
	add $t1,$t1,4		# increment the array index
	add $t0,$t0,1		# increment the loop counter


	#WHILE counter is less than size of the array jump back to print
	blt $t0,$t7,print	# if the counter < size of the array jump back to print


endp:	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

	
	#Calculate min and max of the array
	#Reinitialize loop values
	li $t0,0		# initialize counter back to zero
	li $t1,0		# initialize array index back to zero


	#Initialize min and max to first array element
        lw $t2,array($t1)       # t2 = min = a[0] (initialization)
        lw $t3,array($t1)       # t3 = max = a[0] (initialization)


	#Move pointer to compare next array element
        add $t1,$t1,4       	# move index ahead to next array element a[1]
        add $t0,$t0,1      	# increment counter to keep in step with array


loop:   #Compare integers of the array
	lw $t6,array($t1)       # load word a[i] into temp (t6)
        bge $t6,$t2,notMin  	# if array element is >= min goto notMin
        move $t2,$t6        	# min = a[i]
        j notMax


notMin: ble $t6,$t3,notMax 	# if array element is <= max goto notMax
        move $t3,$t6        	# max = a[i]


notMax: add $t0,$t0,1      	# t1 -- -> counter --
        add $t1,$t1,4       	# increment counter to point to next word
        blt $t0,$t7,loop	# loop back if counter is less than array size


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


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display name and due date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# display "Brandon LaPointe ~ Due : 10/18/2021"


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display OCC advisor
	la $a0, advisor		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# display "OCC Advisor : Sheila S. Sicilia"


	#End the program
       	li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

        
.data

prompt:		.asciiz "Please enter 10 integer values : "	# Prompt for user to enter 10 integers
intPrompt:	.asciiz "Enter an integer : "			# Prompt for user to enter an integer
title:		.asciiz "Array : "				# Title for array
comma:		.asciiz ", "					# Comma character for output
endl:    	.asciiz "\n"					# New line character
min:     	.asciiz "The minimum number is "		# Min number output
max:     	.asciiz "\nThe maximum number is "		# Max number output
name:   	.asciiz "Brandon LaPointe ~ Due : 10/18/2021" 	# Output name and due date
advisor:	.asciiz "OCC Advisor : Sheila S. Sicilia"	# Output OCC advisor
array: 		.word 10