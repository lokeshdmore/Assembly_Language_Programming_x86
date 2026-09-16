/* =================================================================
 *	Code   : Arithematic Operators -> Unary Plus
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 9th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print:
    .string "%d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl  main
.type   main, @function 
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp
    movl    $(+10), -4(%ebp)

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    pushl   $(+10)
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    pushl   $0
    call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */
