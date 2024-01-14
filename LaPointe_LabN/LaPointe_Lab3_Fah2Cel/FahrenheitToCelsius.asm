########### fah2cel.asm #############

        .text
        .globl main
main:

        #Print out prompt
        la $a0,prompt        # load beginning address of string into $a0 register
        li $v0,4             # load call code to print a string into register $v0
        syscall              # system call to display "Enter temperature (Fahrenheit):"


        #Get the temperature from User
        li $v0,6             # load call code to read a float from keyboard
        syscall              # system call to read float and store in $f0


        #Initialize float values for conversion
        li.s $f6, 9.0
        li.s $f8 5.0
        li.s $f10, 32.0


	#Convert Fehrenheit to Celsius: (F − 32) × 5/9 = C
	sub.s $f2,$f0,$f10   	# temperature-32
	mul.s $f2,$f2,$f8    	# temperature-32*5
	div.s $f2,$f2,$f6    	# temperature-32*5/9 and store -> f2


        #Display output message
        la $a0, ans1         	# load beginning address of display message into $a0 register
        li $v0,4             	# load call code to print a string 
        syscall              	# system call to display "The Temperature in Fahrenheit is "

       
        #Display temperature
        mov.s $f12,$f2       	# move Fahrenheit temperature from f2 -> f12 for display
        li  $v0,2            	# load call code to print a float    
        syscall              	# system call to display temperature

       
        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line


	#Display name and date
	la $a0, name		# load beginning address of display message into $a0 register
	li $v0,4		# load call code to print a string
	syscall			# system call to display "Brandon LaPointe 09/14/2021 "


        #Move to next line       
        la $a0,endl          	# display cr/lf
        li $v0,4             	# load call code to print a string (new line is a string)
        syscall              	# system call to move to next line

       
        #End the program
        li $v0,10            	# load call code to End Program
        syscall              	# system call to end program

       
   #Data Section
   .data
   prompt: .asciiz "Enter temperature (Fahrenheit): "    #Prompt for Fahrenheit temperature
   name:   .asciiz "Brandon LaPointe 09/14/2021 "	 #Print out of name and date after displaying converted temp
   ans1:   .asciiz "The Temperature in Celsius is "  	 #Output message
   endl:   .asciiz "\n"                                  #New line character

########################## Output ##########################
#Enter temperature (Fahrenheit): 32                        #
#The Temperature in Celsius is 0.00000000                  #
#Brandon LaPointe 09/14/2021                               #
#                                                          #
#Enter temperature (Fahrenheit): 212                       #
#The Temperature in Celsius is 100.00000000                #
#Brandon LaPointe 09/14/2021                               #
#                                                          #
############################################################