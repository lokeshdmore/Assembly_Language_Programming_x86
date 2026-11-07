/* =================================================================
 *	Code   : 3_sub_unsigned_chars
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd Nov 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */

.section .rodata
	msg_main_print_carry_set: 
	.string "Carry Bit Set "

	msg_main_print_carry_notSet: 
	.string "Carry Bit Not Set "


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

    movb    $7, %al
    movb    $8, %dl
    subb    %dl, %al 

    jnc      LABEL_CARRY_NOT_SET
    movl    $msg_main_print_carry_set, (%esp)
    call    puts
    jmp     LABEL_EXIT

LABEL_CARRY_NOT_SET:
    movl    $msg_main_print_carry_notSet, (%esp)
    call    puts
    
LABEL_EXIT:
	movl $0, (%esp) 
	call exit


/* ==================== TEXT SECTION ENDS HERE ===================== */