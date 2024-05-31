			# This code was produced by the CERI Compiler
.data
FormatString1:	.string "%llu"	# used by printf to display 64-bit unsigned integers
FormatString2:	.string "%lf"	# used by printf to display 64-bit floating point numbers
FormatString3:	.string "%c"	# used by printf to display a 8-bit single character
TrueString:	.string "TRUE"	# used by printf to display the boolean value TRUE
FalseString:	.string "FALSE"	# used by printf to display the boolean value FALSE
a:	.quad 0
j:	.quad 0
	.align 8
	.text		# The following lines contain the program
	.globl main	# The main function must be visible from outside
main:			# The main function body :
	movq %rsp, %rbp	# Save the position of the stack's top
	push $2
	pop j
	push $1
	pop a
	push j
	cmpq $100, %rax
	je Case1	# If there is a match, jump
Case1:
	push $5
	pop a
	jmp EndCase0
	cmpq $2, %rax
	je Case2	# If there is a match, jump
Case2:
	push $3
	pop a
	jmp EndCase0
	cmpq $30, %rax
	je Case3	# If there is a match, jump
Case3:
	push $7
	pop a
	jmp EndCase0
ELSE0:
	push j
	push $2
	pop %rbx
	pop %rax
	mulq	%rbx
	push %rax	# MUL
	pop j
	jmp EndCase0
EndCase0:
	movq %rbp, %rsp		# Restore the position of the stack's top
	ret			# Return from main function
