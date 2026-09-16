/* =================================================================
 *	Code   : 05_global_initialized_internal_linkage(main.s)
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 02nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print:
    .string "in main, iNo is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

#definition of static initialized variable
.type   iNo, @object
.size   iNo, 4
.align  4, 4
iNo:
    .int    20

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    movl    iNo, %eax
    pushl   %eax 
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    call    fun

    pushl   $0
    call    exit 


/* ==================== TEXT SECTION ENDS HERE ===================== */

