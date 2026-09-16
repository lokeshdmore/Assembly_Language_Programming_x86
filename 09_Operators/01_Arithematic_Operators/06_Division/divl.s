/* =================================================================
 *	Code   : Arithematic Operators -> Division
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 9th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print1:
    .string "Enter Numerator: \t"

    msg_main_print2:
    .string "Enter Denominator: \t"

    msg_main_print_quotient:
    .string "quotient = %d\n"

    msg_main_print_remainder:
    .string "remainder = %d\n"

    msg_main_scan:
    .string "%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    # giving memory to local variables
    subl    $20, %esp
    
    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    # scan first operand
    leal    -8(%ebp), %ebx
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    # scan second operand
    leal   -12(%ebp), %ecx
    pushl   %ecx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp
    
    movl    -4(%ebp), %edx  # copy operand 1 into eax (MSB) of Numerator
    movl    -8(%ebp), %eax  # copy operand 1 into eax (LSB) of Numerator

    movl    -12(%ebp), %ecx  # copy operand 2 into ecx (Denominator)

    # Division
    divl    %ecx
    movl    %eax, -16(%ebp) # storing quotient
    movl    %edx, -20(%ebp) # storing remainder 

    # print the Division
    pushl   %eax
    pushl   $msg_main_print_quotient
    call    printf
    addl    $8, %esp

    # print the remainder
    pushl   %edx
    pushl   $msg_main_print_remainder
    call    printf
    addl    $8, %esp

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

