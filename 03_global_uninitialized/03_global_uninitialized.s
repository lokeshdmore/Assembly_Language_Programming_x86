/* =================================================================
 *	Code   : 03_global_uninitialized variable
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata

msg_main_print1:
    .string "before scanning, g = %d\n"

msg_main_print2:
    .string "enter the number : \t"

msg_main_scan:
    .string "%d"

msg_main_printResult:
    .string "After Scanning, g is %d\n"


/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== BSS SECTION ========================== */
.section .bss
    .comm g, 4, 4

/* ===================== BSS SECTION ENDS HERE ===================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    movl    g, %eax
    pushl   %eax
    pushl   $msg_main_print1
    call    printf
    addl    $8, %esp

    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

    leal    g, %edx
    pushl   %edx
    pushl   $msg_main_scan
    call    scanf
    addl    $8, %esp

    movl    g, %eax
    pushl   %eax
    pushl   $msg_main_printResult
    call    printf
    addl    $8, %esp

    pushl   $0
    call    exit


/* ==================== TEXT SECTION ENDS HERE ===================== */
