/* =================================================================
 *	Code   : Arithematic Operators -> Multiplication
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 9th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print1:
    .string "Enter operand 1: \t"

    msg_main_print2:
    .string "Enter operand 2: \t"

    msg_main_print3:
    .string "mull answer = %d\n"

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
    subl    $16, %esp
    
    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    # scan first operand
    leal    -4(%ebp), %ebx
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    # scan second operand
    leal   -8(%ebp), %ecx
    pushl   %ecx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp
    
    movl    -4(%ebp), %eax  # copy operand 1 into eax
    movl    -8(%ebp), %ecx  # copy operand 2 into ecx

    # Multiplication
    mull    %ecx
    movl    %eax, -16(%ebp) # storing LSB of result first
    movl    %edx, -12(%ebp) # storing MSB of result 

    # print the result
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print3
    call    printf
    addl    $12, %esp

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */

