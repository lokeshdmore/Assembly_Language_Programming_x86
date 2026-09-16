/* =================================================================
 *	Code   : do while loop
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 29th July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
msg_main_print:
    .string "Enter The iNo: "

msg_main_printf:
    .string "%d\n"

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

    subl    $8, %esp

    pushl   $msg_main_print
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %eax 
    pushl   %eax
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    movl    $0, -8(%ebp)  
    movl    -8(%ebp), %eax


LABEL_DO:
    pushl   %eax 
    pushl   $msg_main_printf
    call    printf
    addl    $8, %esp 

    addl    $1, -8(%ebp)

    # while(iCounter < iNo)
    movl    -8(%ebp), %eax
    movl    -4(%ebp), %edx
    cmpl    %edx, %eax
    jl      LABEL_DO

    pushl   $0
    call    exit 
    

/* ==================== TEXT SECTION ENDS HERE ===================== */
