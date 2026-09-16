/* =================================================================
 *	Code   : 2_global_initialized
 *	Author : Lokesh More <ldmore118@gmail.com>
 *	Course : Assembly Language Programming - Batch 11
 *	Date   : 2nd July 2026
 * ================================================================= */

/* ===================== READY ONLY DATA SECTION =================== */
.section .rodata
    msg_main_print1:
    .string "g is %d\n"

    msg_main_print2:
    .string "&g is %d\n"

/* ================= READY ONLY DATA SECTION ENDS HERE ============= */

/* ========================== DATA SECTION ========================= */
.section .data

.globl g
.type  g,@object
.size  g,4
.align 4,4

g:
.int 10

/* ===================== DATA SECTION ENDS HERE ==================== */

/* ========================== TEXT SECTION ========================= */
.section .text

# main function() execution Code
.globl main
.type main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    movl g, %eax
    pushl %eax
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    leal g, %eax
    pushl %eax
    pushl $msg_main_print2
    call printf
    addl $8, %esp

    pushl $0
    call exit

/* ==================== TEXT SECTION ENDS HERE ===================== */
