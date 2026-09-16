/* =================================================================
 *	Code   : 01 Addition of two numbers using Assembly
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 1st July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_print1 : 
	.string "Enter two numbers : "

	msg_main_scan :
	.string "%d%d"

	msg_main_print2 : 
	.string "Addition is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function execution code
.globl main
.type main,@function
main:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp

	pushl $msg_main_print1
	call printf
	addl $4, %esp

	leal -4(%ebp), %eax
	leal -8(%ebp), %edx
	pushl %edx
	pushl %eax
	pushl $msg_main_scan
	call scanf
	addl $12, %esp

	movl -4(%ebp), %eax
	movl -8(%ebp), %edx
	pushl %edx
	pushl %eax
	call addition
	addl $8, %esp
	movl %eax, -12(%ebp)

	pushl %eax
	pushl $msg_main_print2
	call printf
	addl $8, %esp

	pushl $0
	call exit

# addition function() execution code
.globl addition
.type addition,@function
addition:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl 12(%ebp), %edx
	addl %edx, %eax
	movl %eax, -4(%ebp)

	movl %ebp, %esp
	popl %ebp
	ret

/* ==================== TEXT SECTION ENDS HERE ===================== */