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
    .string "result : %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

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

    movb    $130, %al
    movb    $0, %dl
    subb    %dl, %al 

    jno     LABEL_Overflow_NOT_SET
    movl    $msg_main_print_Overflow_set, (%esp)
    call    puts
    jmp     LABEL_EXIT

LABEL_Overflow_NOT_SET:
    movl    $msg_main_print_Overflow_notSet, (%esp)
    call    puts
    
LABEL_EXIT:
	movl    $0, (%esp) 
	call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */
