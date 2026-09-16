/* =================================================================
 *	Code   : Relational Operators -> Demo_01
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 22nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print1:
    .string "Enter three numbers: \t"

msg_main_scan:
    .string "%d%d%d"

msg_main_printAns:
    .string "Answer is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main 
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $16, %esp

    pushl   $msg_main_print1
    call    printf
    addl    $4, %esp

    # scaning the three integers
    leal    -4(%ebp),   %eax
    leal    -8(%ebp),   %edx
    leal    -12(%ebp),  %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $16, %esp

    # iAns = iNo1 < iNo2 != iNo3
    movl    -4(%ebp), %eax  #iNo1 
    movl    -8(%ebp), %edx  #iNo2 
    cmpl    %edx, %eax 
    jl      IF_LESS_THAN_TRUE
    movl    $0, %eax
    jmp     IF_LESS_THAN_FALSE

IF_LESS_THAN_TRUE:
    movl    $1, %eax 

IF_LESS_THAN_FALSE:
    movl    -12(%ebp), %ecx #iNo3    
    cmpl    %ecx, %eax 
    jne     IF_NOT_EQUAL_TRUE
    movl    $0, %eax
    jmp     IF_NOT_EQUAL_FALSE

IF_NOT_EQUAL_TRUE:
    movl    $1, %eax

IF_NOT_EQUAL_FALSE:
    # printing the answer
    movl    %eax, -16(%ebp)
    pushl   %eax
    pushl   $msg_main_printAns
    call    printf
    addl    $8, %esp 

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */
