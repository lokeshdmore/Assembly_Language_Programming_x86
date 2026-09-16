/* =================================================================
 *	Code   : Switch Case With Break
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 29th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_case1:
    .string "addition\n"

msg_main_case2:
    .string "subtraction\n"

msg_main_case3:
    .string "multiplication\n"

msg_main_case4:
    .string "division\n"

msg_main_default:
    .string "Invalid Choice\n"

msg_main_print:
    .string "Enter the number: "

msg_main_scan:
    .string "%d"


/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    addl    $4, %esp

    pushl   $msg_main_print
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    #switch(choice)
    movl    -4(%ebp), %eax
    cmpl    $1, %eax
    je      LABEL_CASE1
    cmpl    $2, %eax
    je      LABEL_CASE2
    cmpl    $3, %eax
    je      LABEL_CASE3
    cmpl    $4, %eax
    je      LABEL_CASE4
    jmp     LABEL_CASE_DEFAULT

LABEL_CASE1:
    pushl   $msg_main_case1
    call    printf
    addl    $4, %esp
    jmp     LABEL_CALL_EXIT
    
LABEL_CASE2:
    pushl   $msg_main_case2
    call    printf
    addl    $4, %esp
    jmp     LABEL_CALL_EXIT

LABEL_CASE3:
    pushl   $msg_main_case3
    call    printf
    addl    $4, %esp
    jmp     LABEL_CALL_EXIT

LABEL_CASE4:
    pushl   $msg_main_case4
    call    printf
    addl    $4, %esp
    jmp     LABEL_CALL_EXIT


LABEL_CASE_DEFAULT:
    pushl   $msg_main_default
    call    printf
    addl    $4, %esp

LABEL_CALL_EXIT:
    pushl   $0
    call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */
