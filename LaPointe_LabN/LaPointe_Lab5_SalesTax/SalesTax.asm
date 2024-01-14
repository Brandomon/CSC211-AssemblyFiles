########### SalesTax.asm #############

        .text
        .globl main
main:

        #Print out prompt
        la $a0,prompt       	# load beginning address of string into $a0 register
        li $v0,4             	# load call code to print a string into register $v0
        syscall              	# system call to display "Enter the cost of the item: $"


        #Get the item cost from User
        li $v0,6             	# load call code to read a float from keyboard
        syscall              	# system call to read float and store in $f0	


        #Initialize float value for tax calculation
	li.s $f2,0.08


        #Calculate item tax
	mul.s $f4,$f0,$f2	# cost * 0.08 -> $f4


	#Calculate total cost
	add.s $f6,$f0,$f4	# cost + tax -> $f6


        #Display tax output message
        la $a0,tax         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "Sales Tax: $"

       
        #Display item tax
        mov.s $f12,$f4       	# move sales tax float from $f4 -> $f12 for display
        li $v0,2            	# load call code to print a float    
        syscall              	# system call to display item tax

       
        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line


        #Display total output message
        la $a0,total         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "Total: $"

       
        #Display total
        mov.s $f12,$f6       	# move total float from $f6 -> $f12 for display
        li $v0,2            	# load call code to print a float    
        syscall              	# system call to display total

       
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
   prompt: 	.asciiz "Enter the cost of the item: $"		#Prompt for item cost
   tax:    	.asciiz "Sales Tax: $"				#Output message for the tax amount
   total:	.asciiz "Total: $"				#Output message for the total cost
   name:   	.asciiz "Brandon LaPointe 09/15/2021 "	 	#Output name and date
   endl:    	.asciiz "\n"					#New line character

############################ Output #############################
#Enter the cost of the item: $4299.98				#
#Sales Tax: $343.99838257					#
#Total: $4643.97851563						#
#Brandon LaPointe 09/15/2021 					#
#								#
#################################################################