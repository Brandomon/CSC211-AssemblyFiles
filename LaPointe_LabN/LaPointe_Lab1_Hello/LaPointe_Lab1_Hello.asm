############# Hello.asm ############
#          Brandon LaPointe        #
####################################


        .text
        .globl main
main:


	la $a0,prompt                   # load address of prompt into a0
	li $v0,4                        # load callcode/instruction number to display a string into v0
	syscall                         # system call to print the prompt string


	li $a1,20       		# set string length
	la $a0,string   		# get address of string variable
	li $v0,8        		# service call number for reading string from keyboard into v0
	syscall          		# read String


	la $a0,endl                     # load the new line character into a0
	li $v0,4                        # load the call code number to display the string into v0
	syscall                         # system call to move to next line


	la $a0,output			# display output message
	li $v0,4			# load address of output into a0
	syscall				# system call to print output


	move $t0,$v0                    # move string from v0 -> t0 for safe keeping


	la $a0,string  			# load address of string into a0
     	li $v0,4       			# load instruction number to display a string into v0
     	syscall         		# system call to print the string


	la $a0,output2			# display output message
	li $v0,4			# load address of output into a0
	syscall				# system call to print output


	la $a0,endl                     # load the new line character into a0
	li $v0,4                        # load the call code number to display the string into v0
	syscall                         # system call to move to next line


	li $v0,10                       # exit
	syscall				# system call


	#####data section######

	.data

	prompt: .asciiz "Enter your name: "           				# prompt for the user's name input
	string: .space 21 							# directive to initialize number of characters in string
	output: .asciiz "Hello, "  						# output message
	endl:   .asciiz "\n"      						# new line
	output2:.asciiz "Welcome to the 2021 Fall semester of CSC 211!"		# output message 2
 
#################### Output ####################
#Enter your name: Brandon                      #
#                                              #
#Hello, Brandon                                #
#Welcome to the 2021 Fall semester of CSC 211! #
#                                              #
################################################