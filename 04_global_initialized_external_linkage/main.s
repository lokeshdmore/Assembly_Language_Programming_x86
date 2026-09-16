/* =================================================================
 *	Code   : 04_global_initialized_external_linkage (main.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print:
    .string "In main, number is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== TEXT SECTION ========================= */
.section .text
.globl  main
.type   main, @function
main:
    movl    g_iNo, %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    call    fun

    pushl   $0
    call    exit

/* ==================== TEXT SECTION ENDS HERE ===================== */
