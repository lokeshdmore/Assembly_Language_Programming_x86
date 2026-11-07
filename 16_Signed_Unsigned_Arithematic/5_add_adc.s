/* =================================================================
 *	Code   : 4_sub_signed_chars
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd Nov 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_print_Overflow_set: 
	.string "Overflow Bit Set "

	msg_main_print_Overflow_notSet: 
	.string "Overflow Bit Not Set "

    msg_main_print_result:
    .string "addition is : %qd\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

.globl data1
.type  data1,@object
.size  data1,8
.align 4

data1:
.quad 2147483648


.globl data2
.type  data2,@object
.size  data2,8
.align 4

data2:
.quad 2147483648



/* ===================== DATA SECTION ENDS HERE ==================== */




/* ========================== TEXT SECTION ========================= */
.section .text

# main function execution code
.globl main
.type main,@function
main:
    andl    $(-16), %esp
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp

    movl    data1, %eax
    movl    data1+4, %edx

    movl    data2, %ecx
    movl    data2+4, %ebx

    addl    %eax, %ecx
    adcl    %edx, %ebx

    movl   $msg_main_print_result, (%esp)
    movl    %ecx, 4(%esp)
    movl    %ebx, 8(%esp)
    call    printf 

LABEL_EXIT:
	movl    $0, (%esp) 
	call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */

