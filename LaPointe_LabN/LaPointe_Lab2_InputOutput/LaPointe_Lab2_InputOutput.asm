########## InputOutput.asm #########
#         Brandon LaPointe         #
####################################


        .text
        .globl main
main:


	la $a0,prompt1                  # load address of prompt1 into a0
	li $v0,4                        # load callcode/instruction number to display a string into v0
	syscall                         # system call to print the prompt string


	li $v0,5			# load call code number to read an integer -> v0
	syscall				# system call to read the integer and store in v0


	move $t0,$v0                    # move integer from v0 -> t0 for safe keeping


	la $a0,prompt2                  # load address of prompt2 into a0
	li $v0,4                        # load callcode/instruction number to display a string into v0
	syscall                         # system call to print the prompt string


	li $v0,5			# load call code number to read an integer -> v0
	syscall				# system call to read the integer and store in v0


	move $t1,$v0                    # move integer from v0 -> t1 for safe keeping


	la $a0,endl                     # load the new line character into a0
	li $v0,4                        # load the call code number to display the string into v0
	syscall                         # system call to move to next line


	la $a0,output1			# load address of output message into a0
	li $v0,4			# load call code number to display a string into v0
	syscall				# system call to print output string


	move $a0,$t1			# move integer from t1 -> a0 for display
	li $v0,1			# load call code number to display the integer into v0
	syscall				# system call to print the integer


	la $a0,output2			# load address of output2 message into a0
	li $v0,4			# load call code number to display a string into v0
	syscall				# system call to print output string


	move $a0,$t0			# move integer from t0 -> a0 for display
	li $v0,1			# load call code number to display the integer into v0
	syscall				# system call to print the integer


	la $a0,output3			# load address of output3 message into a0
	li $v0,4			# load call code number to display a string into v0
	syscall				# system call to print output string


	la $a0,endl                     # load the new line character into a0
	li $v0,4                        # load the call code number to display the string into v0
	syscall                         # system call to move to next line


	li $v0,10                       # exit
	syscall				# system call


	#####data section######

	.data

	prompt1:.asciiz "Enter your age: "           				# prompt for the user's name input
	prompt2:.asciiz "Enter year born: "					# prompt for the user's birth year
	output1:.asciiz "You were born in "  					# output message 1
	output2:.asciiz " and you are "						# output message 2
	output3:.asciiz " years old. "						# output message 3
	endl:   .asciiz "\n"      						# new line
 
#################### Output #####################
#Enter your age: 26                             #
#Enter year born: 1995                          #
#                                               #
#You were born in 1995 and you are 26 years old.# 
#                                               #
#                                               #
#################################################