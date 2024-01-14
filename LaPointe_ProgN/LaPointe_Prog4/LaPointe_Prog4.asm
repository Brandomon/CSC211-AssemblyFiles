######################################## LaPointeProg4.asm #########################################
#
####################################################################################################
#	Program Name:	Counting  
#	Author:		Brandon LaPointe
#	Due Date:	October 02, 2021
#	Course/Section:	CSC 211-301W
#  Program Description:	Prompts the user to input an integer and prints the digits from 1 to that number
####################################################################################################
#
#	$t0 - User input integer
#	$t1 - Counter 1	(Outer Loop / Total Number Counter)
#	$t2 - Counter 2 (Inner Loop / Rows of 10 Counter)
#	$t3 - Counter 3 (Right Justification Max Space Counter)
#	$t4 - Counter 4 (Space Counter)
#
####################################################################################################
#
# Initial Algorithm:
#
# Prompt user for an integer
# Print digits from 1 to input
#	Move to new line after 10 numbers
#		Count max number of additional digits
#			Count additional spaces for digit
#				Add spaces depending on digit length
#					Print digit and space
#					Increment digit and jump back to beginning
#
# Input Variables:   	
#   Int1 As Integer:	User input to print digits up to
#
# Output Variables: NONE
#
# Additional Variables:	NONE
#
####################################################################################################
#
# Refined Algorithm:
#
# BEGIN COUNTING
# 1.  Print out prompt1 to gather the integer
#         Store first integer in $t0 for safe keeping
# 2.  Print out digits from 1 to input number
#	 Initialize counters 1-3 to 1
#	 Initialize counter 4 to 0
#	 WHILE counter is less than or equal to input, print digits
#outer loop	IF counter > user input ($t0) skip to endOuter
#innerLoop		IF counter2 = 10 then Branch to ELSE
#	 		IF counter2 < 10 then
#				IF counter > user input ($t0) skip to end of outer loop
#					IF counter2 <= 10 skip to end of inner loop
#					IF counter = 10 then print the new line character
#					initialize counter back to one
#					WHILE counter3 is less than input, increment counter4 and multiply counter3 by 10
#countLoop					IF counter3 >= user input, skip to count spaces
#						IF counter3 < user input, multiply counter3 by 10 and store in $t3
#						jump back to WHILE counter3 is less than input
#countSpaces						IF counter1 >= counter 3, skip to addSpaces
#							IF counter1 < counter3, divide counter3 by 10 and decrement counter4
#							jump back to countSpaces
#addSpaces							IF counter4 = 0, print digit
#								IF counter4 > 0, add space and decrement counter4
#								jump back to addSpaces	
#print									get next number for display (counter1)
#									print digit and space
#									increment counter1 and counter2
#									reset counter3 to 1
#									reset counter4 to 0
#									jump back to outerLoop
#endOuter	Move to next line 
#		Display name and date
#		Move to next line
# 		END COUNTING
#
####################################################################################################

        .text
        .globl main
main:


        #Print out prompt1
        la $a0,prompt1       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter an integer : "


        #Get the value of the integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	#Move user input integer to $t0
	move $t0,$v0		# move integer from $v0 -> $t0 for safe keeping


        #Print out digits from 1 to input number
	#Initialize integer value for counters
	li $t1, 1		# set counter to 1
	li $t2, 1		# set counter2 to 1
	li $t3, 1		# set counter3 to 1
	li $t4, 0		# set counter4 to 0
	
	
	#Initialize integer value for count loop
	li $t5, 10			# set $t4 to 10 for adding spaces math


	#WHILE counter is less than or equal to input, Print digits
outLoop:bgt $t1, $t0, endOuter		# outer loop: if counter > user input ($t0) skip to end of outer loop
	
inLoop: ble $t2, 10, countLoop 		# inner loop: if counter2 <= 10 skip to countLoop
	la $a0,endl			# IF counter = 10 then print the new line character
        li $v0,4			# load call code to print a string (new line is a string)
        syscall				# system call to move to next line
	li $t2, 1			# initialize counter back to one

	#Right-justification loop
	#WHILE counter3 is less than input, increment counter4 and multiply counter3 by 10
countLoop:
	bge $t3, $t0, countSpaces	# count loop: if counter3 >= user input, skip to count spaces
	mul $t3, $t3, $t5		# IF counter3 < user input, multiply counter3 by 10 and store in $t3
	j countLoop			# jump back to countLoop

countSpaces:
	bge $t1, $t3, addSpaces		# count spaces: IF counter1 >= counter 3, skip to addSpaces
	div $t3, $t3, $t5		# IF counter1 < counter3, divide counter3 by 10 and increment counter4
	add $t4, 1			# increment counter 4
	j countSpaces			# jump back to countSpaces


addSpaces:
	beqz $t4, print			# add spaces: IF counter4 = 0, print number
	la $a0,space			# IF counter4 > 0, add space and decrement counter4
	li $v0,4			# load call code to print a string
	syscall				# system call to print a space
	sub $t4, 1			# decrement counter4 by 1
	j addSpaces			# jump back to addSpaces
	

print:	move $a0,$t1			# get next number for display (counter1)
	li $v0,1			# load call code to print an integer
	syscall				# system call to print counter1
	la $a0,space			# load beginning address of space character into $a0 register
	li $v0,4			# load call code to print a string
	syscall				# system call to print a space
	add $t1,1			# increment counter
	add $t2,1			# increment counter2
	li $t3, 1			# reset counter3 back to 1
	li $t4, 0			# reset counter4 back to 0	
	j outLoop			# jump back to outLoop

endOuter:
	#Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 10/02/2021 "


        #Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   ####Data Section####
   .data
   prompt1: 	.asciiz "Enter an integer : "						#Prompt for integer from user
   name:   	.asciiz "Brandon LaPointe 10/02/2021 "	 				#Output name and date
   endl:    	.asciiz "\n"								#New line character
   space:	.asciiz " "								#Space character


############################################## Output ###################################################
#Enter an integer : 10023										#
#     1      2      3      4      5      6      7      8      9     10 					#
#    11     12     13     14     15     16     17     18     19     20 					#
#		..(shortened to show right-justified)..							#
#    81     82     83     84     85     86     87     88     89     90 					#
#    91     92     93     94     95     96     97     98     99    100 					#
#   101    102    103    104    105    106    107    108    109    110 					#
#		..(shortened to show right-justified)..							#
#   981    982    983    984    985    986    987    988    989    990 					#
#   991    992    993    994    995    996    997    998    999   1000 					#
#  9991   9992   9993   9994   9995   9996   9997   9998   9999  10000 					#
# 10001  10002  10003  10004  10005  10006  10007  10008  10009  10010 					#
# 10011  10012  10013  10014  10015  10016  10017  10018  10019  10020 					#
# 10021  10022  10023 											#
#Brandon LaPointe 10/02/2021 										#
#													#
#########################################################################################################