
STUDENT_POSITION = 4
STUDENT_NAME = 12
STUDENT_SECRET_NUM = 4

STUDENT_SIZE = STUDENT_POSITION + STUDENT_NAME + STUDENT_SECRET_NUM

STUDENT_POSITION_OFFSET = 0
STUDENT_NAME_OFFSET = STUDENT_POSITION_OFFSET + STUDENT_POSITION
STUDENT_SECRET_NUM_OFFSET = STUDENT_NAME_OFFSET + STUDENT_NAME

	.data
secret_number_0:
	.word 10
secret_number_1:
	.word 42
secret_number_2:
	.word 37
secret_number_3:
	.word 99
secret_number_4:
	.word 85


	.text
main:

loop_init:
	li	$t2, 0				# $t2: int i = 0
loop_cond:
	bge	$t2, 5, loop_end
loop_body:

################################################
# 1. Calculate the address of ith element in array

	la	$t0, students
	move	$t1, $t2
	mul	$t1, STUDENT_SIZE

	add	$s0, $t0, $t1			# $s0: students[i]

################################################
# 2a. Calculate the address of the `position` field in struct element 

	add	$s1, $s0, STUDENT_POSITION_OFFSET

	lw	$a0, ($s1)			
	li	$v0, 1	
	syscall					# *(students[i].position)

	li	$a0, ' '
	li	$v0, 11
	syscall

################################################
# 2b. Calculate the address of the `name` field in struct element 

	add	$s2, $s0, STUDENT_NAME_OFFSET   # offsetting from the base element address
	

	move	$a0, $s2			# Note: We don't load the value with `lw` because its a string
	li	$v0, 4
	syscall					# *(students[i].name)

	li	$a0, ' '
	li	$v0, 11
	syscall

################################################
# 2c. Calculate the address of the `secret_number` field in struct element 

	add	$s3, $s2, STUDENT_NAME		# offsetting from the previous field address

	lw	$s4, ($s3)			# load value out of array

	lw	$a0, ($s4)			# load value out of pointer
	li	$v0, 1
	syscall					# *(students[i].secret_number)

	li	$a0, '\n'
	li	$v0, 11
	syscall

################################################

loop_step:
	addi	$t2, 1
	b	loop_cond
loop_end:

	jr	$ra


	.data

students:
# Disclaimer: You should use `.align` and `.space` for an uninitialised array
	.word 0
	.byte 'J','i','n','g','w','e','n','\0', 0, 0, 0, 0
	.word secret_number_0

	.word 1
	.byte 'J','o','s','h','\0', 0, 0, 0, 0, 0, 0, 0
	.word secret_number_1

	.word 2
	.byte 'J','u','s','t','i','n','\0', 0, 0, 0, 0, 0
	.word secret_number_2

	.word 3
	.byte 'T','o','b','i','a','s','\0', 0, 0, 0, 0, 0
	.word secret_number_3

	.word 4
	.byte 'W','i','l','l','i','a','m','\0', 0, 0, 0, 0
	.word secret_number_4


	.space 4
	.space 10


student:					# address to the struct coordinate
	.word 0
	.asciiz "Chloe"
	.word secret_number_0

