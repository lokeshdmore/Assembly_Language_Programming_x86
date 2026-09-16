/* =================================================================
 *	Code   : logical_AND ( && )
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 23rd JULY 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print_no:
    .string "Enter three numbers : "

msg_main_print_result:
    .string "result : %d\n"

msg_main_print_iNo1:
    .string "iNo1 : %d\n"

msg_main_print_iNo2:
    .string "iNo2 : %d\n"

msg_main_print_iNo3:
    .string "iNo3 : %d\n"

msg_main_scan:
    .string "%d%d%d"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %ebp, %esp

    subl    $16, %esp

    pushl   $msg_main_print_no
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax
    leal    -8(%ebp), %edx
    leal    -12(%ebp), %ecx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $16, %esp

    // iAns = iNo1 && ++iNo2 && ++iNo3;
    movl    -4(%ebp), %eax
    cmpl    $0, %eax
    je      LABEL_EXIT
    addl    $1, -8(%ebp)
    movl    -8(%ebp), %edx
    cmpl    $0, %edx
    je      LABEL_EXIT
    addl    $1, -12(%ebp)
    movl    -12(%ebp), %ecx
    cmpl    $0, %ecx
    je      LABEL_EXIT
    movl    $1, %ecx 

    je      LABEL_EXIT
    movl    %ecx, -16(%ebp)



LABEL_EXIT:
    pushl   %ecx
    pushl   msg_main_print_result
    call    printf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   msg_main_print_iNo1
    call    printf
    addl    $8, %esp

    movl    -8(%ebp), %eax
    pushl   %eax
    pushl   msg_main_print_iNo2
    call    printf
    addl    $8, %esp

    movl    -12(%ebp), %eax
    pushl   %eax
    pushl   msg_main_print_iNo3
    call    printf
    addl    $8, %esp

LABEL_SECOND_AND:

/* ==================== TEXT SECTION ENDS HERE ===================== */
    
