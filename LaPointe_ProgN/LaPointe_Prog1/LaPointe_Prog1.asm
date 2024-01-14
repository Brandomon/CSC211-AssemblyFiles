######################################## LaPointeProg1.asm #########################################

####################################################################################################
#	Program Name:	Integer Math using Order of Operations      
#	Author:		Brandon LaPointe
#	Due Date:	September 20, 2021
#	Course/Section:	CSC 211-301W
#  Program Description:	Prompts the user to input 5 integers and calculates (a - b) + (c - d) * e
####################################################################################################


        .text
        .globl main
main:


        #Print out prompt
        la $a0,prompt       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the variables for (a - b) + (c - d) * e"


        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line


        #Print out prompt1
        la $a0,prompt1       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the integer for a : "


        #Get the value of variable a from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	move $t1,$v0		# move integer from $v0 -> $t1 for safe keeping


        #Print out prompt2
        la $a0,prompt2       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the integer for b : "


        #Get the value of variable a from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	move $t2,$v0		# move integer from $v0 -> $t2 for safe keeping


        #Print out prompt3
        la $a0,prompt3       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the integer for c : "


        #Get the value of variable a from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	move $t3,$v0		# move integer from $v0 -> $t3 for safe keeping


        #Print out prompt4
        la $a0,prompt4       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the integer for d : "


        #Get the value of variable a from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	move $t4,$v0		# move integer from $v0 -> $t4 for safe keeping


        #Print out prompt5
        la $a0,prompt5       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the integer for e : "


        #Get the value of variable a from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read float and store in $v0


	move $t5,$v0		# move integer from v0 -> t5 for safe keeping


        #Calculate the equation (a - b) + (c - d) * e
	sub $t6,$t1,$t2		# (a - b) -> $t6
	sub $t7,$t3,$t4		# (c - d) -> $t7
	mul $t8,$t7,$t5		# (c - d) * e -> $t8
	add $t9,$t6,$t8		# (a - b) + (c - d) * e -> $t9


        #Display left parenthesis
        la $a0,leftpar         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "("

       
        #Display variable a
        move $a0,$t1       	# move integer a from $t1 -> $a0 for display
        li $v0,1            	# load call code to print an integer   
        syscall              	# system call to display variable a


	#Display minus symbol
	la $a0,minus         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " - "


        #Display variable b
        move $a0,$t2       	# move integer a from $t2 -> $a0 for display
        li $v0,1            	# load call code to print an integer   
        syscall              	# system call to display variable b


	#Display right parenthesis
        la $a0,rightpar         # load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display ")"


	#Display plus symbol
	la $a0,plus         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " + "


	#Display left parenthesis
        la $a0,leftpar         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "("

       
        #Display variable c
        move $a0,$t3       	# move integer a from $t3 -> $a0 for display
        li $v0,1            	# load call code to print an integer   
        syscall              	# system call to display variable c


	#Display minus symbol
	la $a0,minus         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " - "


        #Display variable d
        move $a0,$t4       	# move integer a from $t4 -> $a0 for display
        li $v0,1            	# load call code to print an integer   
        syscall              	# system call to display variable d


	#Display right parenthesis
        la $a0,rightpar         # load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display ")"


	#Display multiplication symbol
	la $a0,multi         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " * "


	#Display variable e
        move $a0,$t5       	# move integer a from $t5 -> $a0 for display
        li $v0,1            	# load call code to print an integer   
        syscall              	# system call to display variable e


	#Display equals symbol
	la $a0,equals         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " = "

       
        #Display solution
        move $a0,$t9       	# move integer total from $t9 -> $a0 for display
        li $v0,1            	# load call code to print an integer    
        syscall              	# system call to display solution

       
        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 09/15/2021 "


        #Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   ####Data Section####
   .data
   prompt:	.asciiz "Enter the variables for (a - b) + (c - d) * e"	#Prompt for displaying the equation
   prompt1: 	.asciiz "Enter the integer for a : "			#Prompt for first integer
   prompt2: 	.asciiz "Enter the integer for b : "			#Prompt for second integer
   prompt3: 	.asciiz "Enter the integer for c : "			#Prompt for third integer
   prompt4: 	.asciiz "Enter the integer for d : "			#Prompt for fourth integer
   prompt5: 	.asciiz "Enter the integer for e : "			#Prompt for fifth integer
   leftpar:    	.asciiz "("						#Output for left parenthesis
   rightpar:    .asciiz ")"						#Output for right parenthesis
   minus:	.asciiz " - "						#Output for minus symbol
   plus:	.asciiz " + "						#Output for plus symbol
   multi:	.asciiz " * "						#Output for multiplication symbol
   equals:	.asciiz " = "						#Output for equals symbol
   name:   	.asciiz "Brandon LaPointe 09/15/2021 "	 		#Output name and date
   endl:    	.asciiz "\n"						#New line character

################################## Output ###############################
#Enter the variables for (a - b) + (c - d) * e				#
#Enter the integer for a : 12						#
#Enter the integer for b : 23						#
#Enter the integer for c : 34						#
#Enter the integer for d : 42						#
#Enter the integer for e : 143						#
#(12 - 23) + (34 - 42) * 143 = -1155					#
#Brandon LaPointe 09/15/2021 						#
#									#
#########################################################################
