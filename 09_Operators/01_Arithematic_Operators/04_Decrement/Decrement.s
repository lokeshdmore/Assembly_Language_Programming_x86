/* =================================================================
 *	Code   : Arithematic Operators -> Decrement Operator
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

    # post decrement
    movl    -4(%ebp), %eax  # eax = iAns1
    movl    %eax, -12(%ebp)
    subl    $1, -4(%ebp)
    movl    -4(%ebp), %edx  # edx = iNo1

    # pre decrement
    subl    $1, -8(%ebp) 
    movl    -8(%ebp), %ecx  # iNo2  = ecx
    movl    %ecx, -16(%ebp) # iAns2 = ecx

    pushl   %ecx
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   $msg_main_print
    call    printf
    addl    $20, %esp

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

