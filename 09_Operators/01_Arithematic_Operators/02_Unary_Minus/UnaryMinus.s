/* =================================================================
 *	Code   : Arithematic Operators -> Unary Minus
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
    movl    $10, -4(%ebp)

    pushl   $(-100)
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    # push negative value without negl instruction
    movl    $0, %eax
    movl    -4(%ebp), %ebx
    subl    %ebx, %eax
    pushl   %eax

    pushl   $msg_main_print
    call    printf
    addl    $8, %esp
    
    # push negative value with negl instruction
    movl    -4(%ebp), %eax
    negl    %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp
    

    pushl   $0
    call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */
