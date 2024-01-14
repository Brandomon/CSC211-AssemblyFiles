####################################################################################################
#
# LaPointe_Prog6.asm - Prompts user to enter 10 integers to be stored within an array before
#			displaying the formatted array, calculating and displaying the minimum
#			and maximum within the array, sorting the array using a bubble sort in
#			ascending order, and then displaying the formatted sorted array.
#
#	$t0 = min && max
#	$t1 = counter && outer loop counter (i)
#	$t2 = index counter && inner loop counter (j)
#	$t3 = end index for outer loop (# of items - 1) * 4
#	$t4 = end index for inner loop (# of items * 4)
#	$t5 = j - 1 (1 integer word being 4 bytes)
#	$t6 = array element && contents of array(j)
#	$t7 = contents of array(j-1)
#	$t8 = temp register 1
#	$t9 = temp register 2
#
#	$s0 = # of items in array
#	$s1 = end index for comma loop (# of items - 1)
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
# Print min and max
# Bubble Sort
# Print sorted array using index
#
# Input Variables:  	
#   	($t6) as int - User input used to fill the array of integers
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN PROGRAM
# 1.  Prompt user for 10 integers
#	Move to next line
#	Initialize size of array
#	Initialize size of array - 1
#	Initialize counter to zero
#	Initialize index to zero
# 2.  Collect and store integers in array
#while  Prompt user for integer
#	Store input from keyboard
#	Store integer into array
#	Increment array index and loop counter
#	WHILE counter is less than size of array jump back to while
#wend	Move to next line
#	Display title
#	Reinitialize loop values
#print  Print out the integers of the array
#	Print comma if counter is not equal to array size - 1
#skip	Increment array index and loop counter
#	WHILE counter is less than size of the array jump back to print
#endp	Move to next line
#	Calculate min and max of the array
#	Calculate and display minimum
#	Reinitialize loop values
#	Initialize min to first array element
#	Move pointer to compare next array element
#minLoop
#	Compare integers of the array for minimum
#	IF array element is >= min goto notMin
#	IF array element is < min
#		min = a[i]
#notMin increment counter to point to next word
#	loop back if counter is less than array size
#	Display min message
#	Display min
#	Calculate and display maximum
#	Reinitialize loop values
#	Initialize max to first array element
#	Move pointer to compare next array element
#maxLoop
#	Compare integers of the array for maximum
#	IF array element is <= min goto notMax
#	IF array element is > max
#		max = a[i]
#notMax increment counter to point to next word
#	loop back if counter is greater than array size
#	Display max message
#	Display max
#	Move to next line
#	Bubble Sort
#	Load number of items in array into register -> $s0
#	Reinitialize loop values
#	Compute end index for outer loop and store in $t3
#	Compute end index for inner loop and store in $t4
#	Begin sorting
#outer	branch to endOuter if outer counter equals outer end (when i = (# of items - 1) * 4)
#inner	branch to endInner if inner counter equals inner end (when  j = (# of items) * 4)
#	compute j – 1 by subtracting 4 bytes from j and store in $t5
#	load word at array(j - 1) into a temporary register
#	load word at array(j) into temporary register 2
#	branch to noSwap if first temporary register  >  temporary register 2
#	store array(j) into temp register 2
#	store array(j - 1) into array (j)
#	store temp register into array(j - 1)
#noSwap increment j by 4 because each integer is 4 bytes
#	jump to inner
#endInner
#	increment i by 4 because each integer is 4 bytes
#	initialize j back to 4 and begin next inner loop value
#	jump to outer
#endOuter
#	Move to next line
#	Display title2
#	Reinitialize loop values
#print2 Print out the integers of the array
#	Print comma if counter is not equal to array size - 1
#	Print out comma
#skip2	Increment array index and loop counter
#	WHILE counter is less than size of the array jump back to print
#endp2	Move to next line
#	Move to next line
#	Display name and due date
#	Move to next line
#	Display bucket list item
# END PROGRAM
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


	#Initialize size of array
	li $s0, 10		# size of array -> $s0


	#Initialize size of array - 1
	li $s1, 9		# size of array - 1 -> $s1


	#Initialize counter to zero
	li $t1, 0		# init loop counter to 0


	#Initialize index to zero
	li $t2, 0		# init index to 0


while:	#Prompt user for integer
	la $a0,intPrompt	# prompt for integer
	li $v0,4		# call code to display a string
	syscall			# display "Enter an integer : "


	#Store input from keyboard
	li $v0,5		# enter input -> $v0
	syscall			# read an integer

	
	#Store integer into array
	move $t6,$v0		# store word int to a[i]
	sw $t6,array($t2)	# store word int into array

	
	#Increment array index and loop counter
	add $t2,$t2,4		# move index ahead to next array element
	add $t1,$t1,1		# increment counter

 
	#WHILE counter is less than size of array jump back to while
	blt $t1,$s0,while	# branch to while if counter < size of array

	
wend:	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display title
	la $a0,title		# display "Array : "
	li $v0,4		# call code to print a string
	syscall			# display "Array : "


	#Reinitialize loop values
	li $t1,0		# initialize counter back to zero
	li $t2,0		# initialize array index back to zero


print:	#Print out the integers of the array
	lw $t8,array($t2)	# load the word a[i] into temp ($t8)
	move $a0,$t8		# move a[i] to $a0 for display
	li $v0,1		# display a[i]
	syscall			# print the integer

	
	#Print comma if counter is not equal to array size - 1
	beq $t1,$s1,skip	#if counter is last of array, skip comma


	#Print out comma
	la $a0,comma		# load the comma character into $a0
	li $v0,4		# load instruction to print a string
	syscall			# print the comma


skip:	#Increment array index and loop counter
	add $t1,$t1,1		# increment the loop counter
	add $t2,$t2,4		# increment the array index


	#WHILE counter is less than size of the array jump back to print
	blt $t1,$s0,print	# if the counter < size of the array jump back to print


endp:	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

	
	#Calculate min and max of the array
	#Calculate and display minimum
	#Reinitialize loop values
	li $t1,0		# initialize counter back to zero
	li $t2,0		# initialize array index back to zero


	#Initialize min to first array element
        lw $t0,array($t2)       # $t0 = min = a[0] (initialization)


	#Move pointer to compare next array element
        add $t1,$t1,1      	# increment counter to keep in step with array
	add $t2,$t2,4       	# move index ahead to next array element a[1]


minLoop:#Compare integers of the array for minimum
	lw $t8,array($t2)       # load word a[i] into temp($t8)
        bge $t8,$t0,notMin  	# if array element is >= min goto notMin
        move $t0,$t8        	# min = a[i]


notMin:	add $t1,$t1,1      	# t1 -- -> counter --
        add $t2,$t2,4       	# increment counter to point to next word
        blt $t1,$s0,minLoop	# loop back if counter is less than array size


	#Display min message
        la $a0,min           	# load address of min message into $a0 for display
        li $v0,4            	# call code to display a string
        syscall             	# display "The minimum number is : "

      
	#Display the minimum number 
        move $a0,$t0        	# Display the minimum number 
        li $v0,1		# call code to display an integer
        syscall			# display min number


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

	
	#Calculate and display maximum
	#Reinitialize loop values
	li $t1,0		# initialize counter back to zero
	li $t2,0		# initialize array index back to zero


	#Initialize max to first array element
        lw $t0,array($t2)       # $t0 = max = a[0] (initialization)


	#Move pointer to compare next array element
        add $t1,$t1,1      	# increment counter to keep in step with array
	add $t2,$t2,4       	# move index ahead to next array element a[1]


maxLoop:#Compare integers of the array for minimum
	lw $t8,array($t2)       # load word a[i] into temp($t8)
        ble $t8,$t0,notMax  	# if array element is >= min goto notMax
        move $t0,$t8        	# min = a[i]


notMax:	add $t1,$t1,1      	# t1 -- -> counter --
        add $t2,$t2,4       	# increment counter to point to next word
        blt $t1,$s0,maxLoop	# loop back if counter is less than array size


	#Display max message
        la $a0,max           	# load address of min message into $a0 for display
        li $v0,4            	# call code to display a string
        syscall             	# display "The maximum number is : "

      
	#Display the maximum number 
        move $a0,$t0        	# Display the maximum number 
        li $v0,1		# call code to display an integer
        syscall			# display max number


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Bubble Sort
	#Load number of items in array into register -> $s0
	#Reinitialize loop values
	li $t1,0		# initialize outer loop counter (i) back to zero
	li $t2,4		# initialize inner loop counter (j) back to first integer word (4)


	#Compute end index for outer loop and store in $t3
	sub $t3,$s0,1		# number of items - 1
	mul $t3,$t3,4		# (number of items - 1) * 4


	#Compute end index for inner loop and store in $t4
	mul $t4,$s0,4		# compute the # of items * 4 and store back in $t4


	#Begin sorting
outer:	beq $t1,$t3, endOuter	# branch to endOuter if outer counter equals outer end (when i = (# of items - 1) * 4)

	
inner:	beq $t2,$t4, endInner	# branch to endInner if inner counter equals inner end (when  j = (# of items) * 4)
	sub $t5,$t2,4		# compute j – 1 by subtracting 4 bytes from j and store in $t5
	lw $t8,array($t5)	# load word at array(j - 1) into a temporary register
	lw $t9,array($t2)	# load word at array(j) into temporary register 2
	blt $t8,$t9, noSwap	# branch to noSwap if first temporary register  >  second temporary register

	
	lw $t9,array($t2)	# store array(j) into temp register 2
	sw $t8,array($t2)	# store array(j - 1) into array (j)
	sw $t9,array($t5)	# store temp register into array(j - 1)


noSwap:	add $t2,$t2,4		# increment j by 4 because each integer is 4 bytes
	j inner			# jump to inner


endInner:
	add $t1,$t1,4		# increment i by 4 because each integer is 4 bytes
	li $t2,4		# initialize j back to 4 and begin next inner loop value
	j outer			# jump to outer


endOuter:
	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display title2
	la $a0,title2		# display "Sorted Array : "
	li $v0,4		# call code to print a string
	syscall			# display "Sorted Array : "


	#Reinitialize loop values
	li $t1,0		# initialize counter back to zero
	li $t2,0		# initialize array index back to zero


print2:	#Print out the integers of the array
	lw $t8,array($t2)	# load the word a[i] into temp ($t8)
	move $a0,$t8		# move a[i] to $a0 for display
	li $v0,1		# display a[i]
	syscall			# print the integer

	
	#Print comma if counter is not at end
	beq $t1,$s1,skip2	#if counter is last of array, skip comma


	#Print out comma
	la $a0,comma		# load the comma character into $a0
	li $v0,4		# load instruction to print a string
	syscall			# print the comma


skip2:	#Increment array index and loop counter
	add $t1,$t1,1		# increment the loop counter
	add $t2,$t2,4		# increment the array index


	#WHILE counter is less than size of the array jump back to print
	blt $t1,$s0,print2	# if the counter < size of the array jump back to print2


endp2:	#Move to next line
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
	syscall			# display "Brandon LaPointe ~ Due : 11/01/2021"


	#Move to next line
	la $a0,endl         	# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display bucket list item
	la $a0, bucket		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# display "#1 Bucket List Item : A contemporary house to call home"


	#End the program
       	li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

        
.data

prompt:		.asciiz "Please enter 10 integer values : "				# Prompt for user to enter 10 integers
intPrompt:	.asciiz "Enter an integer : "						# Prompt for user to enter an integer
title:		.asciiz "Array : "							# Title for array
title2:		.asciiz "Sorted Array : "						# Title for sorted array
comma:		.asciiz ", "								# Comma character for output
endl:    	.asciiz "\n"								# New line character
min:     	.asciiz "The minimum number is "					# Min number output
max:     	.asciiz "\nThe maximum number is "					# Max number output
name:   	.asciiz "Brandon LaPointe ~ Due : 11/01/2021" 				# Output name and due date
bucket:		.asciiz "#1 Bucket List Item : A contemporary house to call home"	# Output first item on bucket list
array: 		.word 10								# Array of 10 integer words