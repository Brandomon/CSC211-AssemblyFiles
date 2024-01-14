########### SubtractingIntegers.asm #############

        .text
        .globl main
main:

        #Print out prompt1
        la $a0,prompt1       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter an integer: "


        #Get the first integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read integer and store in $v0


	move $t0,$v0         	# move integer from $v0 -> $t0 for safe keeping


        #Print out prompt2
        la $a0,prompt2       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall             	# system call to display "Enter a second integer: "


        #Get the second integer from User
        li $v0,5             	# load call code to read an integer from keyboard
        syscall              	# system call to read integer and store in $v0


	move $t1,$v0         	# move second integer from $v0 -> $t1 for safe keeping


	#Compute the difference of the two integers
	sub $t2,$t0,$t1		# subtract $t0 from $t1 and store in $t2


        #Display output message
        la $a0,ans1         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "The difference is "

       
        #Display difference
        move $a0,$t2       	# move difference integer from $t2 -> $a0 for display
        li $v0,1            	# load call code to print an integer    
        syscall              	# system call to display difference

       
        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line

	
	#Display first part of equation
	move $a0,$t0		# move integer from $t0 -> $a0 for display
	li $v0,1		# load call code to print an integer
	syscall			# system call to display first part of equation


	#Display minus sign
	la $a0,minus		# load beginning address of minus message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " - "


	#Display second part of equation
	move $a0,$t1		# move integer from $t1 -> $a0 for display
	li $v0,1		# load call code to print an integer
	syscall			# system call to display second part of equation


	#Display equals sign
	la $a0,equals		# load beginning address of equals message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display " = "


	#Display difference of equation
	move $a0,$t2		# move integer from $t2 -> $a0 for display
	li $v0,1		# load call code to print an integer
	syscall			# system call to display difference of equation

       
        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 09/14/2021 "


        #Move to next line       
        la $a0,endl		# display cr/lf
        li $v0,4		# load call code to print a string (new line is a string)
        syscall			# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   ####Data Section####
   .data
   prompt1: 	.asciiz "Enter an integer: "			#Prompt for first integer
   prompt2: 	.asciiz "Enter a second integer: "		#Prompt for second integer
   ans1:    	.asciiz "The difference is "			#Output message
   minus:	.asciiz " - "					#Output for minus
   equals:	.asciiz " = "					#Output for equals
   name:   	.asciiz "Brandon LaPointe 09/14/2021 "	 	#Output name and date
   endl:    	.asciiz "\n"					#New line character

####################### Output #######################
#Enter an integer: 12				     #
#Enter a second integer: 4			     #
#The difference is 8				     #
#12 - 4 = 8					     #
#Brandon LaPointe 09/14/2021 			     #
#						     #
######################################################