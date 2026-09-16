/* =================================================================
 *	Code   : Arithematic Operators -> Increment Operator
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 9th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print:
    .string " iNo1 = %d\n iNo2 = %d\n iAns1 = %d\n iAns2 = %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp

    movl    $10, -4(%ebp)
    movl    $20, -8(%ebp)

    # pre-increment
    movl    -4(%ebp), %eax
    addl    $1, %eax
    movl    %eax, -4(%ebp)
    movl    %eax, -12(%ebp)
    
    # post-Increment
    movl    -8(%ebp), %edx
    movl    %edx, -16(%ebp)
    addl    $1, %edx
    movl    %edx, -8(%ebp)
    movl    -16(%ebp), %ecx

    pushl   %ecx
    pushl   %eax
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $20, %esp

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

